//
//  BeachBallScreen.m
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "BeachBallScreen.h"
#import "BeachBall.h"
#import "Vector2.h"
#import "TouchEvent.h"
#import "NSArray+TouchEvents.h"
#import "Assets.h"

@implementation BeachBallScreen

- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game {
    self = [super init];
    if(self) {
        //NSLog(@"--- BeachBallScreen - initWithGameHelper");
        gameHelper = gameHelp;
        
        spriteBatcher = [[SpriteBatcher alloc] initWithMaxSprites:110];
        beachballs = [[NSMutableArray alloc] init];
        for(int i=0; i<100; i++) {
            BeachBall *beachball = [[BeachBall alloc] init];
            [beachballs addObject:beachball];
        }
        camera2d = [[Camera2D alloc] initWithFrustrumWidth:[gameHelper width] AndFrustrumHeight:[gameHelper height] AndGameHelper:gameHelper];
        fpsCounter = [[FPSCounter alloc] init];
        touchEvents = [gameHelper touchEvents];
        assets = [gameHelper assets];
    }
    return self;
}

- (void)update:(float)deltaTime {
    //NSLog(@"--- BeachBallScreen - update");
    for(BeachBall *s in beachballs) {
        [s update:deltaTime];
    }
    
    
    
    // mark touch coord that "begins"
    // get distance to latest "move" point
    // use distance to set the scale of the object
    
    
    //NSArray *touchEvents = [gameHelper touchEvents];
    
    
    if(touchEvents) {
        if([touchEvents count] > 0) {
            NSLog(@"total events: %d", [touchEvents totalCount]);
            for(TouchEvent *touchEvent in touchEvents) {                
            }
        }
        
    }
    
    
   }

- (void)present:(float)deltaTime {
    
    // clear screen
    glClearColor(1, 0, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT);

    // enable textures
    glEnable(GL_TEXTURE_2D);
    
    // set camera
    [camera2d setViewportAndMatrices];
     
    // set blending on
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    
    // start batch
    [spriteBatcher beginBatch:[assets beachball]];

    // draw sprites
    for(BeachBall *beachball in beachballs) {
        float scale = [beachball scale] * 30;
        [spriteBatcher drawSpriteWithX:[beachball x] AndY:[beachball y] AndWidth:scale AndHeight:scale AndAngle:[beachball angle] AndTextureRegion:[assets beachballRegion]];
        
    }
    [spriteBatcher endBatch];
    [fpsCounter logFrame];
}

- (void)resume {
    NSLog(@"--- BeachBallScreen - resume!");

    //texture = [[Texture alloc] initWithFileName:@"beachball.png"];
    //beachBallRegion = [[TextureRegion alloc] initWithTexture:texture AndX:0 AndY:0 AndWidth:32 AndHeight:32];

    //NSLog(@"BeachBallScreen width: %d height: %d", [gameHelper width], [gameHelper height]);
}

- (void)pause {
    NSLog(@"--- BeachBallScreen - pause!");
    
}

@end
