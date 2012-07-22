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
