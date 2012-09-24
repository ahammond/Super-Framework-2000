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
//  GameScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLScreen.h"
#import "Camera2D.h"
#import "SpriteBatcher.h"
#import "World.h"
#import "WorldListener.h"
#import "WorldRenderer.h"
#import "Rectangle.h"
#import "FPSCounter.h"
#import "GLGame.h"

#define GAME_READY 0
#define GAME_RUNNING 1
#define GAME_PAUSED 2
#define GAME_LEVEL_END 3
#define GAME_OVER 4

@interface GameScreen : GLScreen {
    int state;
    Camera2D *guiCam;
    Vector2 *touchPoint;
    SpriteBatcher *batcher;
    World *world;
    WorldListener *worldListener;
    WorldRenderer *renderer;
    Rectangle *pauseBounds;
    Rectangle *resumeBounds;
    Rectangle *quitBounds;
    int lastScore;
    NSString *scoreString;
    FPSCounter *fpsCounter;
    Assets *assets;
    
    Rectangle *leftScreenBounds;
    Rectangle *rightScreenBounds;
}

- (void)updateReady;
- (void)updateRunning:(float)deltaTime;
- (void)updatePaused;
- (void)updateLevelEnd;
- (void)updateGameOver;
- (void)presentReady;
- (void)presentRunning;
- (void)presentPaused;
- (void)presentLevelEnd;
- (void)presentGameOver;

@end
