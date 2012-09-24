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
//  BeachBall.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "BeachBall.h"

@implementation BeachBall {
    
}

@synthesize x, y, angle, scale;

-(id)init {
    self = [super init];
    if(self) {
        //NSLog(@"--- BeachBall - init");
        x = arc4random() % 320;
        y = arc4random() % 480;
        dirX = 50;
        dirY = 50;
        scale = random() % 11 * 0.1;
        angle = arc4random() % 360;
        scaleup = YES;
    }
    return self;
}

-(void)update:(float)deltaTime {
    x = x + dirX * deltaTime;
    y = y + dirY * deltaTime;
    angle += 5;
    
    if (x < 0) {
        dirX = -dirX;
        x = 0;
    }
    if (x > 320) {
        dirX = -dirX;
        x = 320;
    }
    if (y < 0) {
        dirY = -dirY;
        y = 0;
    }
    if (y > 480) {
        dirY = -dirY;
        y = 480;
    }
    
    if (angle > 360)
        angle = 0;
    
    if (scaleup) {
        scale += 0.05;
        if (scale > 2) {
            scaleup = NO;
        }
    }
    
    if (!scaleup) {
        scale -= 0.05;
        if (scale < 0.5) {
            scaleup = YES;
        }
    }
    
}


@end
