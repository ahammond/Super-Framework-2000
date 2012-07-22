//
//  DynamicGameObject.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "DynamicGameObject.h"

@implementation DynamicGameObject

@synthesize velocity, accel;

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height {
    self = [super initWithX:x AndY:y AndWidth:width AndHeight:height];
    if(self) {
        velocity = [[Vector2 alloc] init];
        accel = [[Vector2 alloc] init];
    }
    return self;
}

@end
