//
//  TouchEvent.m
//  FrameworkPort
//
//  Created by Sage on 7/8/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "TouchEvent.h"

@implementation TouchEvent

// @synthesize x, y, touchType;

- (id)initWithType:(TouchType)touchType TouchNumber:(int)touches AndX:(float)x AndY:(float)y {
    self = [super self];
    if(self) {
        _x = x;
        _y = y;
        _touchNumber = touches;
        _touchType = touchType;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"TouchType:%d TouchNumber:%d x:%f y:%f", [self touchType], [self touchNumber], [self x], [self y]];
}

@end
