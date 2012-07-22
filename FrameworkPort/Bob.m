//
//  Plane.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Bob.h"
#import "World.h"

@implementation Bob

- (id)initWithX:(float)x AndY:(float)y {
    self = [super initWithX:x AndY:y AndWidth:BOB_WIDTH AndHeight:BOB_HEIGHT];
    if(self) {
        _state = BOB_STATE_FALL;
        _stateTime = 0;
        gravity = [[Vector2 alloc] initWithX:0 AndY:-12];
    }
    return self;
}

- (void)update:(float)deltaTime {
    [[self velocity]add:([gravity x] * deltaTime) AndY:([gravity y] * deltaTime)];
    [[self position]add:([[self velocity]x] * deltaTime) AndY:([[self velocity]y] * deltaTime)];
    
    [[[self bounds]lowerLeft]set:[self position]];
    [[[self bounds]lowerLeft]sub:([[self bounds]width] / 2) AndY:([[self bounds]width] / 2)];
       
    // set state to jump if upward velocity is greater than 0 and he's not being hit
    if([[self velocity]y] > 0 && _state != BOB_STATE_HIT) {
        if (_state != BOB_STATE_JUMP) {
            _state = BOB_STATE_JUMP;
            _stateTime = 0;
        }
    }
    
    // sets state to fall if upward velocity is less than 0 and he's not being hit
    if([[self velocity]y] < 0 && _state != BOB_STATE_HIT) {
        if(_state != BOB_STATE_FALL) {
            _state = BOB_STATE_FALL;
            _stateTime = 0;
        }
    }
        
    // wrap world so bob can go around the screen
    if([[self position]x] < 0) {
        [[self position]setX:WORLD_WIDTH];
    }
    if([[self position]x] > WORLD_WIDTH) {
        [[self position]setX:0];
    }
    //NSLog(@"bob position: %f, %f", [[self position]x], [[self position]y]);
    
    _stateTime += deltaTime;
}

- (void)hitSquirrel {
    [[self velocity]set:0 AndY:0];
    _state = BOB_STATE_HIT;
    _stateTime = 0;
}

- (void)hitPlatform {
    [[self velocity]setY:BOB_JUMP_VELOCITY];
    _state = BOB_STATE_JUMP;
    _stateTime = 0;
}

- (void)hitSpring {
    [[self velocity]setY:(BOB_JUMP_VELOCITY * 1.5f)];
    _state = BOB_STATE_JUMP;
    _stateTime = 0;
}


@end
