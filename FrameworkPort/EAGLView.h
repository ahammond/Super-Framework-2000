//
//  EAGLView.h
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "MyGame.h"
#import "SuperJumperGame.h"
#import "AccelerometerData.h"
#import "AudioManager.h"
#import "MusicManager.h"

@interface EAGLView : UIView <UIAccelerometerDelegate> {
@private
    BOOL D;
    
    // ---------------- declare my game!
    // MyGame *myGame;
    SuperJumperGame *superJumperGame;
    // ---------------- end declare my game!
        
    // inputs!
    NSMutableArray *touchEvents;
    //AccelerometerHandler *accelHandler;
    AccelerometerData *accelData;
    
    // Audio !
    AudioManager *audioMan;
    
    // Music!
    MusicManager *musicMan;
    
    // gamehelper reference
    GameHelper *gameHelper;
	
	/* The pixel dimensions of the backbuffer */
	GLint backingWidth;
	GLint backingHeight;
	
	EAGLContext *context;
	
	/* OpenGL names for the renderbuffer and framebuffers used to render to this view */
	GLuint viewRenderbuffer, viewFramebuffer;
	
	/* OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist) */
	GLuint depthRenderbuffer;

	BOOL animating;
	BOOL displayLinkSupported;
	NSInteger animationFrameInterval;
	// Use of the CADisplayLink class is the preferred method for controlling your animation timing.
	// CADisplayLink will link to the main display and fire every vsync when added to a given run-loop.
	// The NSTimer class is used only as fallback when running on a pre 3.1 device where CADisplayLink
	// isn't available.
	id displayLink;
    NSTimer *animationTimer;
    
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView;

@end
