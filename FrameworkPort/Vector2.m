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
//  Vector2.m
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Vector2.h"

static float to_radians = (1 / 180.0) * M_PI;
static float to_degrees = (1 / M_PI) * 180;

@implementation Vector2 {
    
}

- (id)init {
    self = [super init];
    if(self) {
        _x = 0;
        _y = 0;
    }
    return self;
}

- (id)initWithX:(float)x AndY:(float)y {
    self = [super init];
    if(self) {
        _x = x;
        _y = y;
    }
    return self;
}

- (id)initWithVector2:(Vector2 *)vector2 {
    self = [super init];
    if(self) {
        _x = [vector2 x];
        _y = [vector2 y];
    }
    return self;
}

- (Vector2 *)cpy {
    return [[Vector2 alloc] initWithX:_x AndY:_y];
}

- (Vector2 *)set:(float)x AndY:(float)y {
    _x = x;
    _y = y;
    return self;
}

- (Vector2 *)set:(Vector2 *)other {
    _x = [other x];
    _y = [other y];
    return self;
}

- (Vector2 *)add:(float)x AndY:(float)y {
    _x += x;
    _y += y;
    return self;
}

- (Vector2 *)add:(Vector2 *)other {
    _x += [other x];
    _y += [other y];
    return self;
}

- (Vector2 *)sub:(float)x AndY:(float)y {
    _x -= x;
    _y -= y;
    return self;
}

- (Vector2 *)sub:(Vector2 *)other {
    _x -= [other x];
    _y -= [other y];
    return self;
}

- (Vector2 *)mul:(float)scalar {
    _x *= scalar;
    _y *= scalar;
    return self;
}

- (float)len {
    return sqrtf((_x * _x) + (_y * _y));
}

- (Vector2 *)nor {
    float len = [self len];
    if(len != 0) {
        _x /= len;
        _y /= len;
    }
    return self;
}

- (float)angle {
    float angle = atan2f(_y, _x) * [Vector2 TO_DEGREES];
    if (angle < 0) {
        angle += 360;
    }
    return angle;    
}

- (Vector2 *)rotate:(float)angle {
    float rad = angle * [Vector2 TO_DEGREES];
    float _cos = cosf(rad);
    float _sin = sinf(rad);
    
    float newX = _x * _cos - _y * _sin;
    float newY = _x * _sin - _y * _cos;
    
    _x = newX;
    _y = newY;
    
    return self;
}

- (float)dist:(Vector2 *)other {
    float distX = _x - [other x];
    float distY = _y - [other y];
    return sqrtf((distX*distX + distY*distY));
}

- (float)dist:(float)x AndY:(float)y {
    float distX = _x - x;
    float distY = _y - y;
    return sqrtf((distX*distX + distY*distY));    
}

- (float)distSquared:(Vector2 *)other {
    float distX = _x - [other x];
    float distY = _y - [other y];
    return distX*distX + distY*distY;
}

- (float)distSquared:(float)x AndY:(float)y {
    float distX = _x - x;
    float distY = _y - y;
    return distX*distX + distY*distY;
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"x:%f y:%f", [self x], [self y]];
}

+ (float)TO_DEGREES { return to_degrees; }
+ (float)TO_RADIANS { return to_radians; }

@end
