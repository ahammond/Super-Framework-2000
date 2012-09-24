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
//  MainMenuScreen.m
//  FrameworkPort
//
//  Created by Sage on 7/10/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "MainMenuScreen.h"
#import "TouchEvent.h"
#import "OverlapTester.h"
#import "AnimationScreen.h"
#import "GameScreen.h"
#import "HelpScreen.h"

#define MENU_WORLD_WIDTH 320
#define MENU_WORLD_HEIGHT 480

@implementation MainMenuScreen

- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game {
    self = [super init];
    if(self) {
        NSLog(@"--- MainMenuScreen - initWithGameHelper");
        gameHelper = gameHelp;
        batcher = [[SpriteBatcher alloc] initWithMaxSprites:100];
        guiCam = [[Camera2D alloc] initWithFrustrumWidth:MENU_WORLD_WIDTH AndFrustrumHeight:MENU_WORLD_HEIGHT AndGameHelper:gameHelper];
        assets = [gameHelper assets];
        
        // init bounds
        soundBounds = [[Rectangle alloc] initWithX:0 AndY:0 AndWidth:64 AndHeight:64];
        playBounds = [[Rectangle alloc] initWithX:(160-150) AndY:(200+18) AndWidth:300 AndHeight:36];
        highscoresBounds = [[Rectangle alloc] initWithX:(160-150) AndY:(200-18) AndWidth:300 AndHeight:36];
        helpBounds = [[Rectangle alloc] initWithX:(160-150) AndY:(200-18-36) AndWidth:300 AndHeight:36];
        touchPoint = [[Vector2 alloc] init];
        touchEvents = [gameHelper touchEvents];
        glGame = game;
        //NSLog(@"game: %@", glGame);
    }
    return self;
}

- (void)update:(float)deltaTime {
    //NSLog(@"*** MainMenuUpdate");
    
    // get touch up event point
    int touchEventCount = [touchEvents count];
    if(touchEventCount > 0) {
        //NSLog(@"touch events: %d", touchEventCount);
        for(int i=0; i<touchEventCount; i++) {
            TouchEvent *touchEvent = [touchEvents objectAtIndex:i];
            //NSLog(@"TouchEvent: %@", touchEvent);
            if([touchEvent touchType] == TouchEnd) {
                [touchPoint set:[touchEvent x] AndY:[touchEvent y]];
                
                //NSLog(@"- touch: %f, %f", [touchPoint x], [touchPoint y]);
                [guiCam touchToWorld:touchPoint];
                //NSLog(@"-- touch: %f, %f", [touchPoint x], [touchPoint y]);
                
                if([OverlapTester pointInRectangle:playBounds AndPoint:touchPoint]) {
                    NSLog(@"Load Game...");
                    //[glGame setScreen:[[AnimationScreen alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];
                    [glGame setScreen:[[GameScreen  alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];
                    return;
                }

                if([OverlapTester pointInRectangle:highscoresBounds AndPoint:touchPoint]) {
                    NSLog(@"High Scores");
                }

                if([OverlapTester pointInRectangle:helpBounds AndPoint:touchPoint]) {
                    NSLog(@"Help Screen");
                    [glGame setScreen:[[HelpScreen alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];
                }
                
                if([OverlapTester pointInRectangle:soundBounds AndPoint:touchPoint]) {
                    NSLog(@"Sound change");
                } 

            }
        }
    }
}

- (void)present:(float)deltaTime {
    // clear the screen
    glClear(GL_COLOR_BUFFER_BIT);
    
    // set up cam
    [guiCam setViewportAndMatrices];
    
    // enable textures
    glEnable(GL_TEXTURE_2D);
    
    // draw background
    [batcher beginBatch:[assets background]];
    [batcher drawSpriteWithX:160 AndY:240 AndWidth:320 AndHeight:480 AndTextureRegion:[assets backgroundRegion]];
    [batcher endBatch];
    
    // enable transparent blending
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    // draw overlays
    [batcher beginBatch:[assets items]];
    
    [batcher drawSpriteWithX:160 AndY:(480-10-71) AndWidth:274 AndHeight:142 AndTextureRegion:[assets logo]];
    [batcher drawSpriteWithX:160 AndY:200 AndWidth:300 AndHeight:110 AndTextureRegion:[assets mainMenu]];
    [batcher drawSpriteWithX:32 AndY:32 AndWidth:64 AndHeight:64 AndTextureRegion:[assets soundOn]];
    
    [batcher endBatch];
    
    glDisable(GL_BLEND);
    
}

- (void)pause {
    
}

- (void)resume {
    
}

- (void)dispose {
    
}


























@end
