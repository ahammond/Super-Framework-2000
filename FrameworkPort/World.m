//
//  World.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "World.h"
#import "OverlapTester.h"

@implementation World

- (id)initWithWorldListener:(WorldListener *)worldListener {
    self = [super init];
    if (self) {
        gravity = [[Vector2 alloc] initWithX:0 AndY:-12];
        _bob = [[Bob alloc] initWithX:5 AndY:1];
        _platforms = [[NSMutableArray alloc] init];
        _springs = [[NSMutableArray alloc] init];
        _squirrels = [[NSMutableArray alloc] init];
        _coins = [[NSMutableArray alloc] init];
        _listener = worldListener;
        [self generateLevel];
        
        _heightSoFar = 0;
        _score = 0;
        _state = WORLD_STATE_RUNNING;

    }
    return self;
}

- (void)generateLevel {
    float y = PLATFORM_HEIGHT / 2;
    float maxJumpHeight = BOB_JUMP_VELOCITY * BOB_JUMP_VELOCITY / (2 * [gravity y] * -1);
    //NSLog(@"generateLevel y: %f maxJumpHeight: %f gravity y: %f", y, maxJumpHeight, [gravity y]);
    while(y < WORLD_HEIGHT - WORLD_WIDTH / 2) {
        
        // -- Generate platforms
        // if a random number (between 0 and 1) is great than 0.8 (80%) make it moving
        int type = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.8f ? PLATFORM_TYPE_MOVING : PLATFORM_TYPE_STATIC;
        float x = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * (WORLD_WIDTH - PLATFORM_WIDTH) + PLATFORM_WIDTH / 2;
        Platform *platform = [[Platform alloc] initWithType:type AndX:x AndY:y];
        [_platforms addObject:platform];        
        
        //NSLog(@"platform: %f, %f", [[platform position]x], [[platform position]y]);
        
        // add springs
        if(((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.9f && type != PLATFORM_TYPE_MOVING) {
            Spring *spring = [[Spring alloc] initWithX:[[platform position]x] AndY:([[platform position]y] + (PLATFORM_HEIGHT / 2) + SPRING_HEIGHT / 2)];
            [_springs addObject:spring];
        }
        
        // add enemy if greater than 80%
        if(y > WORLD_HEIGHT / 3 && ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.8f) {
            Squirrel *squirrel = [[Squirrel alloc] initWithX:([[platform position]x] + ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)))
                                                        AndY:([[platform position]y] + SQUIRREL_HEIGHT + ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * 2)];
            [_squirrels addObject:squirrel];
        }
        
        // if greater than 60% add coin
        if(((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.6f) {
            Coin *coin = [[Coin alloc] initWithX:([[platform position]x] + ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)))
                                            AndY:([[platform position]y] + COIN_HEIGHT + ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * 3)];
            //NSLog(@"coin: %f, %f", [[coin position]x], [[coin position]y]);
            [_coins addObject:coin];
        }
        
        //
        y += (maxJumpHeight - 0.5f);
        y -= ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * (maxJumpHeight / 3);
    }
    _castle = [[Castle alloc] initWithX:(WORLD_WIDTH / 2) AndY:y];
}

- (void)update:(float)deltaTime AndAccelX:(float)accelX {
    [self updateBob:deltaTime AndAccelX:accelX];
    [self updatePlatforms:deltaTime];
    [self updateSquirrels:deltaTime];
    [self updateCoins:deltaTime];
    if([_bob state] != BOB_STATE_HIT) {
        [self checkCollisions];
    }
    [self checkGameOver];
}

- (void)updateBob:(float)deltaTime AndAccelX:(float)accelX {
    
    if([_bob state] != BOB_STATE_HIT && [[_bob position]y] <= 0.5f) {
        [_bob hitPlatform];
    }
    
    if([_bob state] != BOB_STATE_HIT) {
        [[_bob velocity]setX:(accelX / 10 * BOB_MOVE_VELOCITY)];
    }
    [_bob update:deltaTime];
    _heightSoFar = fmaxf([[_bob position]y], _heightSoFar);
}

// loop through the platforms and remove the ones that have exceed the pulverize time
- (void)updatePlatforms:(float)deltaTime {
    NSMutableArray *discardedItems = [[NSMutableArray alloc] init];
    int len = [_platforms count];
    for(int i=0; i<len; i++) {
        Platform *platform = [_platforms objectAtIndex:i];
        [platform update:deltaTime];
        if(([platform state] == PLATFORM_STATE_PULVERIZING) && ([platform stateTime] > PLATFORM_PULVERIZE_TIME)) {
            // don't do this, instead create an array of items you want to discard and remove them from the array after the loop is done
            //[_platforms removeObject:platform];
            [discardedItems addObject:platform];
        }
    }
    [_platforms removeObjectsInArray:discardedItems];
}

- (void)updateSquirrels:(float)deltaTime {
    int len = [_squirrels count];
    for(int i=0; i<len; i++) {
        Squirrel *squirrel = [_squirrels objectAtIndex:i];
        [squirrel update:(deltaTime)];
    }
}

- (void)updateCoins:(float)deltaTime {
    int len = [_coins count];
    for(int i=0; i<len; i++) {
        Coin *coin = [_coins objectAtIndex:i];
        [coin update:deltaTime];
    }
}

- (void)checkCollisions {
    [self checkPlatformCollisions];
    [self checkSquirrelCollisions];
    [self checkItemCollisions];
    [self checkCastleCollisions];
}

- (void)checkPlatformCollisions {
    if([[_bob velocity]y] > 0)
        return;
    
    int len = [_platforms count];
    for(int i=0; i<len; i++) {
        Platform *platform = [_platforms objectAtIndex:i];
        if([[_bob position]y] > [[platform position]y]) {
            if(([OverlapTester overlapRectangles:[_bob bounds] AndRectangle2:[platform bounds]]) &&
               ([platform state] == PLATFORM_STATE_NORMAL)) {
                //NSLog(@"Platform Collision!");
                [_bob hitPlatform];
                [_listener jump];
                // 50/50 chance of the platform pulverizing
                if (((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.5f) {
                    [platform pulverize];
                }
                break; //save some cpu from iterating through the rest
            }
        }
    }
}

- (void)checkSquirrelCollisions {
    int len = [_squirrels count];
    for(int i=0; i<len; i++) {
        Squirrel *squirrel = [_squirrels objectAtIndex:i];
        if([OverlapTester overlapRectangles:[squirrel bounds] AndRectangle2:[_bob bounds]]) {
            //NSLog(@"Squirrel Collision! at %@ and %@", [_bob bounds], [squirrel bounds]);
            [_bob hitSquirrel];
            [_listener hit];
        }
    }
}

- (void)checkItemCollisions {
    NSMutableArray *discardedItems = [[NSMutableArray alloc] init];
    int len = [_coins count];
    for(int i=0; i<len; i++) {
        Coin *coin = [_coins objectAtIndex:i];
        if([OverlapTester overlapRectangles:[_bob bounds] AndRectangle2:[coin bounds]]) {
            //NSLog(@"Coin Collision!");
            [discardedItems addObject:coin];
            [_listener coin];
            _score += COIN_SCORE;
        }
    }
    [_coins removeObjectsInArray:discardedItems];
    
    if([[_bob velocity]y] > 0) {
        return;
    }
    
    // spring collisions
    len = [_springs count];
    for (int i=0; i<len; i++) {
        Spring *spring = [_springs objectAtIndex:i];
        if([[_bob position]y] > [[spring position]y]) {
            if([OverlapTester overlapRectangles:[_bob bounds] AndRectangle2:[spring bounds]]) {
                [_bob hitSpring];
                [_listener highJump];
            }
        }
    }
    
}

- (void)checkCastleCollisions {
    if([OverlapTester overlapRectangles:[_castle bounds] AndRectangle2:[_bob bounds]]) {
        //NSLog(@"Castle Collision!");
        _state = WORLD_STATE_NEXT_LEVEL;
    }        
}

- (void)checkGameOver {
    if (_heightSoFar - 7.5f > [[_bob position]y]) {
        //NSLog(@"check Game Over!");
        _state = WORLD_STATE_GAME_OVER;
    }
}

@end
