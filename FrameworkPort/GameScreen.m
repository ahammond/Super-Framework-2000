//
//  GameScreen.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GameScreen.h"
#import "TouchEvent.h"
#import "OverlapTester.h"
#import "MainMenuScreen.h"

@implementation GameScreen

- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game {
    self = [super initWithGameHelper:gameHelp AndGLGame:game];
    if(self) {
        glGame = game;
        assets = [gameHelper assets];
        state = GAME_READY;
        guiCam = [[Camera2D alloc] initWithFrustrumWidth:[gameHelp width] AndFrustrumHeight:[gameHelp height] AndGameHelper:gameHelp];
        touchPoint = [[Vector2 alloc] init];
        batcher = [[SpriteBatcher alloc] initWithMaxSprites:1000];
        worldListener = [[WorldListener alloc] initWithGameHelper:gameHelp];
        world = [[World alloc] initWithWorldListener:worldListener];
        renderer = [[WorldRenderer alloc] initWithGameHelper:gameHelp AndSpriteBatcher:batcher AndWorld:world];
        pauseBounds = [[Rectangle alloc] initWithX:(320-64) AndY:480-64 AndWidth:64 AndHeight:64];
        resumeBounds = [[Rectangle alloc] initWithX:(160-96) AndY:240 AndWidth:192 AndHeight:36];
        quitBounds = [[Rectangle alloc] initWithX:(160-96) AndY:(240-36) AndWidth:192 AndHeight:36];
        leftScreenBounds = [[Rectangle alloc] initWithX:80 AndY:240 AndWidth:160 AndHeight:480];
        rightScreenBounds = [[Rectangle alloc] initWithX:240 AndY:240 AndWidth:160 AndHeight:480];
        lastScore = 0;
        scoreString = [[NSString alloc] initWithFormat:@"score: 0"];
        fpsCounter = [[FPSCounter alloc] init];
    }
    return self;
}

- (void)update:(float)deltaTime {

    // disable for now? causes lag? */
    
/*    if(deltaTime > 0.1f) {
        NSLog(@"deltaTime > 0.1f")
        deltaTime = 0.1f;
    } */
    
    switch(state) {
        case GAME_READY:
            [self updateReady];
            break;
        case GAME_RUNNING:
            [self updateRunning:deltaTime];
            break;
        case GAME_PAUSED:
            [self updatePaused];
            break;
        case GAME_LEVEL_END:
            [self updateLevelEnd];
            break;
        case GAME_OVER:
            [self updateGameOver];
            break;
    }
}

- (void)updateReady {
    // get glGame input and check for touch events
    // if touch events, start up game
    if([[gameHelper touchEvents]count] > 0) {
        state = GAME_RUNNING;
    }
}

- (void)updateRunning:(float)deltaTime {
    NSArray *touchEvents = [gameHelper touchEvents];
    int len = [touchEvents count];
    for(int i=0; i<len; i++) {
        TouchEvent *event = [touchEvents objectAtIndex:i];
        if([event touchType] != TouchBegin) {
            //NSLog(@"Event: %@", event);
            continue;
        }
        
        [touchPoint set:[event x] AndY:[event y]];
        [guiCam touchToWorld:touchPoint];
        
        /*
        NSLog(@"touchPoint %@", touchPoint);
        
        if([OverlapTester pointInRectangle:leftScreenBounds AndPoint:touchPoint]) {
            NSLog(@"*** left screen bounds");
        }

        if([OverlapTester pointInRectangle:rightScreenBounds AndPoint:touchPoint]) {
            NSLog(@"*** right screen bounds");
        } */

        
        if([OverlapTester pointInRectangle:pauseBounds AndPoint:touchPoint]) {
            // TODO: play sound click
            state = GAME_PAUSED;
            return;
        }
    }
    
    
    // TODO: get accelX
    //AccelerometerHandler *accelHandler = [gameHelper accelHandler];
    //float accelX = [accelHandler getAccelX] * 10;
    
    AccelerometerData *accelData = [gameHelper accelData];
    float accelX = [accelData accelX];
    accelX *= 10;
    
    //NSLog(@"accelX: %f", accelX);
    //float accelX = 1;
    
    [world update:deltaTime AndAccelX:accelX];
    if ([world score] != lastScore) {
        lastScore = [world score];
        scoreString = [[NSString alloc] initWithFormat:@"%d", lastScore];
    }    
    if([world state] == WORLD_STATE_NEXT_LEVEL) {
        state = GAME_LEVEL_END;
    }
    if([world state] == WORLD_STATE_GAME_OVER) {
        state = GAME_OVER;
        // TODO: set high score if high score is greater than the one saved in settings
        // 
    }    
}

- (void)updatePaused {
    NSArray *touchEvents = [gameHelper touchEvents];
    int len = [touchEvents count];
    for(int i=0; i<len; i++) {
        TouchEvent *event = [touchEvents objectAtIndex:i];
        if([event touchType] != TouchEnd)
            continue;
        
        [touchPoint set:[event x] AndY:[event y]];
        [guiCam touchToWorld:touchPoint];
        
        // resume game
        if([OverlapTester pointInRectangle:resumeBounds AndPoint:touchPoint]) {
            // TODO: play sound click
            state = GAME_RUNNING;
            
            // resume music
            return;
        }
        
        // quit game
        if([OverlapTester pointInRectangle:quitBounds AndPoint:touchPoint]) {
            // TODO: play sound click
            [glGame setScreen:[[MainMenuScreen alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];
            return;
        }
    }    
}

- (void)updateLevelEnd {
    NSArray *touchEvents = [gameHelper touchEvents];
    int len = [touchEvents count];
    for(int i=0; i<len; i++) {
        TouchEvent *event = [touchEvents objectAtIndex:i];
        if([event touchType] != TouchEnd)
            continue;
        
        world = [[World alloc] initWithWorldListener:worldListener];
        renderer = [[WorldRenderer alloc] initWithGameHelper:gameHelper AndSpriteBatcher:batcher AndWorld:world];
        [world setScore:lastScore];
        state = GAME_READY;        
    }
}

- (void)updateGameOver {
    NSArray *touchEvents = [gameHelper touchEvents];
    int len = [touchEvents count];
    for(int i=0; i<len; i++) {
        TouchEvent *event = [touchEvents objectAtIndex:i];
        if([event touchType] != TouchEnd)
            continue;
        [glGame setScreen:[[MainMenuScreen alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];        
    }

}

- (void)present:(float)deltaTime {
    // clear the screen
    glClear(GL_COLOR_BUFFER_BIT);
    
    // enable textures
    glEnable(GL_TEXTURE_2D);
    
    [renderer render];
    
    [guiCam setViewportAndMatrices];
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    [batcher beginBatch:[assets items]];
    switch(state) {
        case GAME_READY:
            [self presentReady];
            break;
        case GAME_RUNNING:
            [self presentRunning];
            break;
        case GAME_PAUSED:
            [self presentPaused];
            break;
        case GAME_LEVEL_END:
            [self presentLevelEnd];
            break;
        case GAME_OVER:
            [self presentLevelEnd];
            break;
    }
    [batcher endBatch];
    glDisable(GL_BLEND);
    [fpsCounter logFrame];
}

- (void)presentReady {
    [batcher drawSpriteWithX:160 AndY:240 AndWidth:192 AndHeight:32 AndTextureRegion:[assets ready]];
}

- (void)presentRunning {
    [batcher drawSpriteWithX:(320-32) AndY:(480-32) AndWidth:64 AndHeight:64 AndTextureRegion:[assets pause]];
    [[assets font]drawText:batcher AndText:scoreString AndX:16 AndY:(480-20)];
}

- (void)presentPaused {
    [batcher drawSpriteWithX:160 AndY:240 AndWidth:192 AndHeight:96 AndTextureRegion:[assets pauseMenu]];
    [[assets font]drawText:batcher AndText:scoreString AndX:16 AndY:(480-20)];
}

- (void)presentLevelEnd {
    NSString *topText = [[NSString alloc] initWithFormat:@"the princess is ..."];
    NSString *bottomText = [[NSString alloc] initWithFormat:@"in another castle!"];
    float topWidth = [[assets font]glyphWidth] * [topText length];
    float bottomWidth = [[assets font] glyphWidth] * [bottomText length];
    [[assets font]drawText:batcher AndText:topText AndX:(160-topWidth/2) AndY:(480-40)];
    [[assets font]drawText:batcher AndText:bottomText AndX:(160-bottomWidth/2) AndY:40];
}

- (void)presentGameOver {
    [batcher drawSpriteWithX:160 AndY:240 AndWidth:160 AndHeight:96 AndTextureRegion:[assets gameOver]];
    float scoreWidth = [[assets font]glyphWidth] * [scoreString length];
    [[assets font]drawText:batcher AndText:scoreString AndX:(160-scoreWidth/2) AndY:(480-20)];    
}


- (void)pause {
    NSLog(@"--- GameScreen pause");
    if(state == GAME_RUNNING) {
        state = GAME_PAUSED;
        //[[gameHelper musicMan]stop];
    }
}

- (void)resume {
    NSLog(@"--- GameScreen resume");
}

- (void)dispose {
    NSLog(@"--- GameScreen dispose");
}

@end
