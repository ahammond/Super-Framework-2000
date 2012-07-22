//
//  World.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bob.h"
#import "Platform.h"
#import "Spring.h"
#import "Squirrel.h"
#import "Coin.h"
#import "Castle.h"
#import "WorldListener.h"

#define WORLD_WIDTH 10
#define WORLD_HEIGHT 15*20
#define WORLD_STATE_RUNNING 0
#define WORLD_STATE_NEXT_LEVEL 1
#define WORLD_STATE_GAME_OVER 2

@interface World : NSObject {
    Vector2 *gravity;
}

// properties
@property Bob *bob;
@property Castle *castle;
@property WorldListener *listener;
@property NSMutableArray *platforms, *squirrels, *coins, *springs;
@property float heightSoFar;
@property int score, state;

- (id)initWithWorldListener:(WorldListener *)worldListener;
- (void)update:(float)deltaTime AndAccelX:(float)accelX;
- (void)generateLevel;
- (void)updateBob:(float)deltaTime AndAccelX:(float)accelX;
- (void)updatePlatforms:(float)deltaTime;
- (void)updateSquirrels:(float)deltaTime;
- (void)updateCoins:(float)deltaTime;
- (void)checkCollisions;
- (void)checkPlatformCollisions;
- (void)checkSquirrelCollisions;
- (void)checkItemCollisions;
- (void)checkCastleCollisions;
- (void)checkGameOver;

@end
