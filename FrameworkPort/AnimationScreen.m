//
//  AnimationScreen.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "AnimationScreen.h"
#import "Caveman.h"
#import "TouchEvent.h"
#import "GLGame.h"
#import "MainMenuScreen.h"
#import "OverlapTester.h"

#define WORLD_WIDTH 4.8 // was 3.2
#define WORLD_HEIGHT 3.2 // was 4.8
#define NUM_CAVEMEN 1

@implementation AnimationScreen {

}

- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game {
    self = [super init];
    if(self) {
        NSLog(@"--- AnimationScreen - initWithGameHelper");
        glGame = game;
        gameHelper = gameHelp;
        batcher = [[SpriteBatcher alloc] initWithMaxSprites:110];
        cavemen = [[NSMutableArray alloc] init];
        camera = [[Camera2D alloc] initWithFrustrumWidth:WORLD_WIDTH AndFrustrumHeight:WORLD_HEIGHT AndGameHelper:gameHelper];
        fpsCounter = [[FPSCounter alloc] init];
        
        for(int i=0; i<NUM_CAVEMEN; i++) {
            Caveman *caveman = [[Caveman alloc] initWithX:((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) AndY:((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) AndWidth:1 AndHeight:1];
            [cavemen addObject:caveman];
        }

        assets = [gameHelper assets];
        touchEvents = [gameHelper touchEvents];
        pauseBounds = [[Rectangle alloc] initWithX:(4.06) AndY:(2.58) AndWidth:0.65 AndHeight:0.5];
        touchPoint = [[Vector2 alloc] init];

    }
    return self;
}

- (void)update:(float)deltaTime {
    //NSLog(@"--- AnimationScreen - update");
    int len = [cavemen count];
    //NSLog(@"cavemen count: %d", len);
    
    // get touch up event point
    int touchEventCount = [touchEvents count];
    if(touchEventCount > 0) {
        //NSLog(@"touch events: %d", touchEventCount);
        for(int i=0; i<touchEventCount; i++) {
            TouchEvent *touchEvent = [touchEvents objectAtIndex:i];
            //NSLog(@"TouchEvent: %@", touchEvent);
            if([touchEvent touchType] == TouchEnd) {
            
                [touchPoint set:[touchEvent x] AndY:[touchEvent y]];
            
                NSLog(@"1 - touch: %f, %f", [touchPoint x], [touchPoint y]);
                [camera touchToWorld:touchPoint];
                NSLog(@"2 - touch: %f, %f", [touchPoint x], [touchPoint y]);
            
                if([OverlapTester pointInRectangle:pauseBounds AndPoint:touchPoint]) {
                    NSLog(@"--- new screen");
                    //[glGame setScreen:[[MainMenuScreen alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];
                    return;
                }
            
            }
        }
    }
    
    for(int i=0; i<len; i++) {
        [[cavemen objectAtIndex:i]update:deltaTime];
    }
}

- (void)present:(float)deltaTime {
    //NSLog(@"--- AnimationScreen - present");
    // clear the screen
    glClearColor(0, 0.5f, 0.5f, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    [camera setViewportAndMatrices];
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_TEXTURE_2D);

    [batcher beginBatch:[assets caveman]];
    int len = [cavemen count];
    for(int i=0; i<len; i++) {
        Caveman *caveman = [cavemen objectAtIndex:i];
        //TextureRegion *keyframe = [walkAnim getKeyFrame:[caveman walkingTime] AndMode:ANIMATION_LOOPING];
        TextureRegion *keyframe = [[assets cavemanWalk]getKeyFrame:[caveman walkingTime] AndMode:ANIMATION_LOOPING];
        //NSLog(@"caveman data: %@", caveman);
        [batcher drawSpriteWithX:[[caveman position]x] AndY:[[caveman position]y] AndWidth:([[caveman velocity]x]<0?1:-1) AndHeight:1 AndTextureRegion:keyframe];
        //[batcher drawSpriteWithX:1 AndY:1 AndWidth:([[caveman velocity]x]<0?1:-1) AndHeight:1 AndTextureRegion:keyframe];
        //NSLog(@"keyFrame data %@", keyframe);
    }
    //NSLog(@"walkanim data %@", walkAnim);
    [batcher endBatch];
    
    // draw background
    [batcher beginBatch:[assets items]];
    [batcher drawSpriteWithX:(WORLD_WIDTH-0.4f) AndY:(WORLD_HEIGHT-0.4f) AndWidth:1 AndHeight:1 AndTextureRegion:[assets arrow]];
    [batcher endBatch];
    
    //[fpsCounter logFrame];
}

- (void)resume {
    NSLog(@"--- AnimationScreen - resume");
}

- (void)pause {
    
}

@end
