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
