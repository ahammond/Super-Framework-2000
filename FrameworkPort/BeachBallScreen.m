// Copyright (c) 2012, Sage Herron <sage@barnhousetech.com>
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software
//    must display the following acknowledgement:
//    This product includes software developed by the <organization>.
// 4. Neither the name of the <organization> nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
