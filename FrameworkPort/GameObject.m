//
//  GameObject.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

@synthesize position, bounds;

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height {
    self = [super init];
    if(self) {
        position = [[Vector2 alloc] initWithX:x AndY:y];
        bounds = [[Rectangle alloc] initWithX:(x-width/2) AndY:(y-height/2) AndWidth:width AndHeight:height];
    }
    return self;
}

@end
