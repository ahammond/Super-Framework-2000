//
//  EAGLView.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "EAGLView.h"
#import "TouchEvent.h"

#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
#define kRenderingFrequency 60.0

// accelerometer
#define kAccelerometerFrequency		60.0 // Hz
#define kFilteringFactor			0.1

@interface EAGLView (EAGLViewPrivate)

- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;

@end

@interface EAGLView (EAGLViewSprite)

- (void)setupView;

@end

@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this
+ (Class) layerClass
{
	return [CAEAGLLayer class];
}


-(id)initWithFrame:(CGRect)frame {    
    // called once after GLSpriteAppDelegate starts
    D = YES;
    
    if((self = [super initWithFrame:frame])) {
        if (D) NSLog(@"--- EAGLView -- initWithFrame");
        // Get the layer
		CAEAGLLayer *eaglLayer = (CAEAGLLayer*) self.layer;
		
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
										[NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
		
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		
		if(!context || ![EAGLContext setCurrentContext:context] || ![self createFramebuffer]) {
			//[self release];
			return nil;
		}        
		
		animating = FALSE;
		displayLinkSupported = FALSE;
		animationFrameInterval = 1; // set default animation rate which is 60/x
		displayLink = nil;
		animationTimer = nil;
		self.multipleTouchEnabled = YES;
        
		// A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
		// class is used as fallback when it isn't available.
		NSString *reqSysVer = @"3.1";
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
			displayLinkSupported = TRUE;
		        
        [EAGLContext setCurrentContext:context];
        [self destroyFramebuffer];
        [self createFramebuffer];
                
        
        
        //Configure and start accelerometer
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        accelData = [[AccelerometerData alloc] init];
        
        // setup the rest - inputs
        touchEvents = [[NSMutableArray alloc] init];
        //accelHandler = [[AccelerometerHandler alloc] init];
        
        // Audio
        audioMan = [[AudioManager alloc] init];
        
        // Music
        musicMan = [[MusicManager alloc] initWithMusic:@"music"];

        // setup gamehelper
        //NSLog(@"EAGLView width: %d height %d", backingWidth, backingHeight);
        gameHelper = [[GameHelper alloc] init];
        [gameHelper setLandscapeMode:NO];
        [gameHelper setWidth:backingWidth];
        [gameHelper setHeight:backingHeight];
        [gameHelper setTouchEvents:touchEvents];
        [gameHelper setAccelData:accelData];
        [gameHelper setAudioMan:audioMan];
        [gameHelper setMusicMan:musicMan];
                
        // --------------------- declare game screen
        // myGame = [[MyGame alloc] initWithGameHelper:gameHelper];
        superJumperGame = [[SuperJumperGame alloc] initWithGameHelper:gameHelper];
        // --------------------- end declare game screen
        
		[self setupView];
		//[self drawView];
	}
	
	return self;    
}


// accelerometer handled
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    float x = [acceleration x];
    float y = [acceleration y];
    float z = [acceleration z];
    [accelData setAccelX:x setAccelY:y setAccelZ:z];
}


// touch events handled
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    int i = 0;
    for(UITouch *touch in touches) {
        CGPoint cgpoint = [touch locationInView:self];
        //if (D) NSLog(@"began - touch# %d x: %f y: %f", i, cgpoint.x, cgpoint.y);
        TouchEvent *touchEvent = [[TouchEvent alloc] initWithType:TouchBegin TouchNumber:i AndX:cgpoint.x AndY:cgpoint.y];
        [touchEvents addObject:touchEvent];
        i++;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //if (D) NSLog(@"--- touchesMoved - count: %d", [touches count]);
    int i = 0;
    for(UITouch *touch in touches) {
        CGPoint cgpoint = [touch locationInView:self];
        //if (D) NSLog(@"moved - touch# %d x: %f y: %f", i, cgpoint.x, cgpoint.y);
        TouchEvent *touchEvent = [[TouchEvent alloc] initWithType:TouchMove TouchNumber:i AndX:cgpoint.x AndY:cgpoint.y];
        [touchEvents addObject:touchEvent];
        i++;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    int i = 0;
    for(UITouch *touch in touches) {
        CGPoint cgpoint = [touch locationInView:self];
        //if (D)NSLog(@"ended - touch# %d x: %f y: %f", i, cgpoint.x, cgpoint.y);
        TouchEvent *touchEvent = [[TouchEvent alloc] initWithType:TouchEnd TouchNumber:i AndX:cgpoint.x AndY:cgpoint.y];
        [touchEvents addObject:touchEvent];
        i++;
    }
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    int i = 0;
    for(UITouch *touch in touches) {
        CGPoint cgpoint = [touch locationInView:self];
        NSLog(@"cancelled - touch# %d x: %f y: %f", i, cgpoint.x, cgpoint.y);
        TouchEvent *touchEvent = [[TouchEvent alloc] initWithType:TouchCancel TouchNumber:i AndX:cgpoint.x AndY:cgpoint.y];
        [touchEvents addObject:touchEvent];
        i++;
    }
    
}


// called after createFrameBuffer
- (void)setupView {
    NSLog(@"--- EAGLView -- setupView");
    //[myGame surfaceCreated];
    [superJumperGame surfaceCreated];
}

- (void)drawView {
    //NSLog(@"--- EAGLView -- drawView");
    
    // Make sure that you are drawing to the current context
	[EAGLContext setCurrentContext:context];
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	// -------- start user code ---------------
    
    
    /*
    for(TouchEvent *event in touchEvents) {
        NSLog(@"--- TouchEvent --- %@", event);
    } */
    
    //NSLog(@"--- accel: %f, %f, %f", [accelHandler getAccelX], [accelHandler getAccelY], [accelHandler getAccelZ] );

    //[myGame updateTouchEvents];
    //[myGame drawFrame];
    [superJumperGame drawFrame];
    
    [touchEvents removeAllObjects];
        
    // -------- end user code ----------------
    // MUST render to viewRenderBuffer !
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
    
}



- (void)layoutSubviews
{
    NSLog(@"--- EAGLView -- layoutSubviews");
    
    
    // moved this code to the init
    
	//[EAGLContext setCurrentContext:context];
	//[self destroyFramebuffer];
	//[self createFramebuffer];
	 //[self drawView];
    //[self setupView];
}


// called after initWithFrame
- (BOOL)createFramebuffer
{
    NSLog(@"--- EAGLView -- createFramebuffer");
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    // For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
    glGenRenderbuffersOES(1, &depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    
	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	return YES;
}


- (void)destroyFramebuffer
{
    NSLog(@"--- EAGLView -- destroyFramebuffer");
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if(depthRenderbuffer) {
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}


- (NSInteger) animationFrameInterval
{
    NSLog(@"--- EAGLView -- animationFrameInterval");
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
    NSLog(@"--- EAGLView -- setAnimationFrameInterval %d", frameInterval);
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
    NSLog(@"--- EAGLView -- startAnimation");
	if (!animating)
	{
        NSLog(@"--- EAGLView -- startAnimation - animating");
		if (displayLinkSupported)
            
		{
            NSLog(@"--- EAGLView -- startAnimation - animating - displayLinkSupported");
			// CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
			// if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
			// not be called in system versions earlier than 3.1.
			
			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView)];
            NSLog(@"--- EAGLView -- startAnimation - animating - displayLinkSupported - setFrameInterval: %d", animationFrameInterval);
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}        
		else {
            NSLog(@"--- EAGLView -- startAnimation - animating - NOT displayLinkSupported");
			animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView) userInfo:nil repeats:TRUE];
        }
		animating = TRUE;
        // --------------- my game resume
        //[myGame resume];
        [superJumperGame resume];
        // ------------------------------
	}
}

- (void)stopAnimation
{
    NSLog(@"--- EAGLView -- stopAnimation");
	if (animating)
	{
        NSLog(@"--- EAGLView -- stopAnimation - not animating");
		if (displayLinkSupported)
		{
            NSLog(@"--- EAGLView -- stopAnimation - not animating - invalidate displayLink");
			[displayLink invalidate];
			displayLink = nil;
		}
		else
		{
            NSLog(@"--- EAGLView -- stopAnimation - not animating - invalidate animationTimer");
			[animationTimer invalidate];
			animationTimer = nil;
		}
		animating = FALSE;
        // ----------- call into mygame and pause
        //[myGame pause];
        [superJumperGame pause];
        // ----------- end code
	}
}

// Release resources when they are no longer needed.
- (void)dealloc
{
    NSLog(@"--- EAGLView -- EAGLView dealloc");
	if([EAGLContext currentContext] == context) {
		[EAGLContext setCurrentContext:nil];
	}
	
	//[context release];
	context = nil;
	
	//[super dealloc];
}

@end