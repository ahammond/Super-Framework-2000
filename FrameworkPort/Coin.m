//
//  Coin.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Coin.h"



@implementation Coin

- (id)initWithX:(float)x AndY:(float)y {
    self = [super initWithX:x AndY:y AndWidth:COIN_WIDTH AndHeight:COIN_HEIGHT];
    if(self) {
        _stateTime = 0;
    }
    return self;
}

- (void)update:(float)deltaTime {
    _stateTime += deltaTime;
}

@end
