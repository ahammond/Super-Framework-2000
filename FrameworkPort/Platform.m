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
