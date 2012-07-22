//
//  Castle.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Castle.h"

@implementation Castle

- (id)initWithX:(float)x AndY:(float)y {
    self = [super initWithX:x AndY:y AndWidth:CASTLE_WIDTH AndHeight:CASTLE_HEIGHT];
    return self;
}

@end
