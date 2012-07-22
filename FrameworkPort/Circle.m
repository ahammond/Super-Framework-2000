//
//  Circle.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Circle.h"

@implementation Circle

@synthesize radius, center;

- (id)initWithX:(float)X AndY:(float)Y AndRadius:(float)Radius {
    self = [super init];
    if(self) {
        center = [[Vector2 alloc] initWithX:X AndY:Y];
        radius = Radius;
    }
    return self;
}

@end
