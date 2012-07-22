//
//  Squirrel.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "DynamicGameObject.h"

#define SQUIRREL_WIDTH 1
#define SQUIRREL_HEIGHT 0.6
#define SQUIRREL_VELOCITY 3.0f

@interface Squirrel : DynamicGameObject

@property float stateTime;

- (id)initWithX:(float)x AndY:(float)y;
- (void)update:(float)deltaTime;

@end
