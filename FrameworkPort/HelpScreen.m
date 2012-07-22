//
//  HelpScreen.m
//  FrameworkPort
//
//  Created by Sage on 7/19/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "HelpScreen.h"
#import "MainMenuScreen.h"

#define HELP_WORLD_WIDTH 320
#define HELP_WORLD_HEIGHT 480

@implementation HelpScreen

- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game {
    self = [super init];
    if(self) {
        gameHelper = gameHelp;
        glGame = game;
        guiCam = [[Camera2D alloc] initWithFrustrumWidth:HELP_WORLD_WIDTH AndFrustrumHeight:HELP_WORLD_HEIGHT AndGameHelper:gameHelper];
        assets = [gameHelper assets];
        touchPoint = [[Vector2 alloc] init];
        
        // menu specific stuff
        nextBounds = [[Rectangle alloc] initWithX:(320-64) AndY:0 AndWidth:64 AndHeight:64];
        batcher = [[SpriteBatcher alloc] initWithMaxSprites:1];
    }
    return self;
}

- (void)resume {
    helpImage = [[Texture alloc] initWithFileName:@"help1.png"];
    helpRegion = [[TextureRegion alloc] initWithTexture:helpImage AndX:0 AndY:0 AndWidth:HELP_WORLD_WIDTH AndHeight:HELP_WORLD_HEIGHT];
}

- (void)pause {
    [helpImage dispose];
}

- (void)update:(float)deltaTime {
    NSArray *touchEvents = [gameHelper touchEvents];
    int len = [touchEvents count];
    for(int i=0; i<len; i++) {
        TouchEvent *event = [touchEvents objectAtIndex:i];
        [touchPoint set:[event x] AndY:[event y]];
        [guiCam touchToWorld:touchPoint];
        
        if([event touchType] == TouchEnd) {
            if([OverlapTester pointInRectangle:nextBounds AndPoint:touchPoint]) {
                [[gameHelper audioMan]playSound:@"click"];
                [glGame setScreen:[[MainMenuScreen alloc] initWithGameHelper:gameHelper AndGLGame:glGame]];
                return;
            }
        }
    }
}

- (void)present:(float)deltaTime {
    glClear(GL_COLOR_BUFFER_BIT);
    [guiCam setViewportAndMatrices];
    
    glEnable(GL_TEXTURE_2D);
    
    [batcher beginBatch:helpImage];
    [batcher drawSpriteWithX:160 AndY:240 AndWidth:320 AndHeight:480 AndTextureRegion:helpRegion];
    [batcher endBatch];
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [batcher beginBatch:[assets items]];
    [batcher drawSpriteWithX:(320 - 32) AndY:32 AndWidth:-64 AndHeight:64 AndTextureRegion:[assets arrow]];
    [batcher endBatch];
    
    glDisable(GL_BLEND);    
}

- (void)dispose {
}

@end
