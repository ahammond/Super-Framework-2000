//
//  WorldRenderer.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameHelper.h"
#import "SpriteBatcher.h"
#import "World.h"
#import "Camera2D.h"

#define FRUSTRUM_WIDTH 10
#define FRUSTRUM_HEIGHT 15

@interface WorldRenderer : NSObject {
    GameHelper *gameHelper;
    World *world;
    Camera2D *cam;
    SpriteBatcher *batcher;
    Assets *assets;
}

- (id)initWithGameHelper:(GameHelper *)gameHelp AndSpriteBatcher:(SpriteBatcher *)theBatcher AndWorld:(World *)theWorld;
- (void)render;
- (void)renderBackground;
- (void)renderObjects;
- (void)renderBob;
- (void)renderPlatforms;
- (void)renderItems;
- (void)renderSquirrels;
- (void)renderCastle;

@end
