//
//  Platform.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "DynamicGameObject.h"

#define PLATFORM_WIDTH 2
#define PLATFORM_HEIGHT 0.5f
#define PLATFORM_TYPE_STATIC 0
#define PLATFORM_TYPE_MOVING 1
#define PLATFORM_STATE_NORMAL 0
#define PLATFORM_STATE_PULVERIZING 1
#define PLATFORM_PULVERIZE_TIME 0.2f * 4
#define PLATFORM_VELOCITY 2

@interface Platform : DynamicGameObject

@property int type, state;
@property float stateTime;

- (id)initWithType:(int)theType AndX:(float)x AndY:(float)y;
- (void)update:(float)deltaTime;
- (void)pulverize;

@end
