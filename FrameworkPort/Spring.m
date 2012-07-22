//
//  Spring.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Spring.h"



@implementation Spring

- (id)initWithX:(float)x AndY:(float)y {
    self = [super initWithX:x AndY:y AndWidth:SPRING_WIDTH AndHeight:SPRING_HEIGHT];
    return self;
}

@end
