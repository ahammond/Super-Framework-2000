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
//  OverlapTester.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "OverlapTester.h"

@implementation OverlapTester

+ (BOOL)overlapCircles:(Circle *)c1 AndCircle2:(Circle *)c2 {
    // float distance = [c1.center distSquared:c2.center]; //alt method
    float distance = [[c1 center]distSquared:[c2 center]];
    float radiusSum = [c1 radius] + [c2 radius];
    return distance <= radiusSum * radiusSum;
}

+ (BOOL)overlapRectangles:(Rectangle *)r1 AndRectangle2:(Rectangle *)r2 {
    if([[r1 lowerLeft]x] < [[r2 lowerLeft]x] + [r2 width] &&
       [[r1 lowerLeft]x] + [r1 width] > [[r2 lowerLeft]x] &&
       [[r1 lowerLeft]y] < [[r2 lowerLeft]y] + [r2 height] &&
       [[r1 lowerLeft]y] + [r1 height] > [[r2 lowerLeft]y]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)overlapCircleRectangle:(Circle *)c AndRectangle:(Rectangle *)r {
    float closetX = [[c center]x];
    float closetY = [[c center]y];
    
    if([[c center]x] < [[r lowerLeft]x]) {
        closetX = [[r lowerLeft]x];
    }
    else if([[c center]x] > [[r lowerLeft]x] + [r width]) {
        closetX = [[r lowerLeft]x] + [r width];
    }
    
    if([[c center]y] < [[r lowerLeft]y]) {
        closetY = [[r lowerLeft]y];
    }
    else if([[c center]y] > [[r lowerLeft]y] + [r height]) {
        closetY = [[r lowerLeft]y] + [r height];
    }
    return [[c center]distSquared:closetX AndY:closetY] < ([c radius] * [c radius]);
}

+ (BOOL)pointInCircle:(Circle *)c AndPoint:(Vector2 *)p {
    return [[c center]distSquared:p] < ([c radius] * [c radius]);
}

+ (BOOL)pointInCircle:(Circle *)c AndX:(float)X AndY:(float)Y {
    return [[c center]distSquared:X AndY:Y] < ([c radius] * [c radius]);
}

+ (BOOL)pointInRectangle:(Rectangle *)r AndPoint:(Vector2 *)p {
    return [[r lowerLeft]x] <= [p x] && [[r lowerLeft]x] + [r width] >= [p x] &&
           [[r lowerLeft]y] <= [p y] && [[r lowerLeft]y] + [r height] >= [p y];
}

+ (BOOL)pointInRectangle:(Rectangle *)r AndX:(float)X AndY:(float)Y {
    return [[r lowerLeft]x] <= X && [[r lowerLeft]x] + [r width] >= X &&
           [[r lowerLeft]y] <= Y && [[r lowerLeft]y] + [r height] >= Y;
}

@end
