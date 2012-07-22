//
//  Spring.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GameObject.h"

@interface Spring : GameObject

#define SPRING_WIDTH 0.3f
#define SPRING_HEIGHT 0.3f

- (id)initWithX:(float)x AndY:(float)y;

@end
