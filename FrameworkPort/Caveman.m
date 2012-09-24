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
//  Caveman.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Caveman.h"
#define WORLD_WIDTH 4.8 // was 3.2
#define WORLD_HEIGHT 3.2 // was 4.8

@implementation Caveman

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height {
    self = [super initWithX:x AndY:y AndWidth:width AndHeight:height];
    if(self) {
        float x = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * WORLD_WIDTH;
        float y = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * WORLD_HEIGHT;
        [[self position]set:x AndY:y];
        float xvel = 0.5f;
        if( ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.5f) {
            xvel = -0.5f;
        }
        [[self velocity]set:xvel AndY:0];
        [self setWalkingTime:( ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * 10 )];

    }
   return self;
}

- (void)update:(float)deltaTime {
    /*
     position.add(velocity.x * deltaTime, velocity.y * deltaTime);
     if(position.x < 0) position.x = WORLD_WIDTH;
     if(position.x > WORLD_WIDTH) position.x = 0;
     walkingTime += deltaTime;
     */
    [[self position]add:([[self velocity]x] * deltaTime) AndY:([[self velocity]y] * deltaTime)];
    if([[self position]x] < 0) {
        //NSLog(@"Rwrap - %f, %f", [[self position]x], [[self position]y]);
        [[self position]setX:WORLD_WIDTH];
    } else if([[self position]x] > WORLD_WIDTH) {
        //NSLog(@"Lwrap - %f, %f", [[self position]x], [[self position]y]);
        [[self position]setX:0];
    }
    float prevWalkingTime = [self walkingTime];
    [self setWalkingTime:(prevWalkingTime + deltaTime)];
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"position: %f,%f", [[self position]x], [[self position]y]];
}

@end
