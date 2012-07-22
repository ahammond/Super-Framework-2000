//
//  Coin.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GameObject.h"

#define COIN_WIDTH 0.5f
#define COIN_HEIGHT 0.8f
#define COIN_SCORE 10

@interface Coin : GameObject

@property float stateTime;

- (id)initWithX:(float)x AndY:(float)y;
- (void)update:(float)deltaTime;

@end
