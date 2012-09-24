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
