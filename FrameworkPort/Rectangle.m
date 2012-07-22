//
//  Rectangle.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle

@synthesize lowerLeft, width, height;

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)theWidth AndHeight:(float)theHeight {
    self = [super init];
    if(self) {
        lowerLeft = [[Vector2 alloc] initWithX:x AndY:y];
        width = theWidth;
        height = theHeight;
    }
    return self;
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"Rectangle: width: %.02f height: %.02f x: %.02f y: %.02f", width, height, [lowerLeft x], [lowerLeft y]];
}

@end
