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
