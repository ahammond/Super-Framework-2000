//
//  Platform.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Platform.h"
#import "World.h"

@implementation Platform

- (id)initWithType:(int)theType AndX:(float)x AndY:(float)y {
    self = [super initWithX:x AndY:y AndWidth:PLATFORM_WIDTH AndHeight:PLATFORM_HEIGHT];
    if (self) {
        _type = theType;
        _state = PLATFORM_STATE_NORMAL;
        _stateTime = 0;
        if(_type == PLATFORM_TYPE_MOVING) {
            [[self velocity]setX:PLATFORM_VELOCITY];
        }
    }
    return self;
}

- (void)update:(float)deltaTime {
    if(_type == PLATFORM_TYPE_MOVING) {
        if ([[self position]y] < 60){
            //NSLog(@"platform velocity: %@ position: %@", [self velocity], [self position]);
        }
        [[self position]add:([[self velocity]x] * deltaTime) AndY:0];
        
        [[[self bounds]lowerLeft]set:[self position]];
        [[[self bounds]lowerLeft]sub:(PLATFORM_WIDTH / 2) AndY:(PLATFORM_HEIGHT / 2)];
        
        if([[self position]x] < PLATFORM_WIDTH / 2) {            
            [[self velocity]setX:(-[[self velocity]x])];
            [[self position]setX:(PLATFORM_WIDTH / 2)];
        }
        
        if([[self position]x] > WORLD_WIDTH - PLATFORM_WIDTH / 2) {
            [[self velocity]setX:(-[[self velocity]x])];
            [[self position]setX:(WORLD_WIDTH - PLATFORM_WIDTH / 2)];
        }
    }
    _stateTime += deltaTime;
}

- (void)pulverize {
    _state = PLATFORM_STATE_PULVERIZING;
    _stateTime = 0;
    [[self velocity]setX:0];
}

@end
