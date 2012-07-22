//
//  Caveman.h
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "DynamicGameObject.h"

@interface Caveman : DynamicGameObject

@property float walkingTime;

- (void)update:(float)deltaTime;

@end
