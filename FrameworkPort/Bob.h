//
//  Plane.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "DynamicGameObject.h"

#define BOB_STATE_JUMP 0
#define BOB_STATE_FALL 1
#define BOB_STATE_HIT 2
#define BOB_JUMP_VELOCITY 11
#define BOB_MOVE_VELOCITY 20 // was 20
#define BOB_WIDTH 0.8f
#define BOB_HEIGHT 0.8f

@interface Bob : DynamicGameObject {
    Vector2 *gravity;
}

@property int state;
@property float stateTime, angle, speed;

- (id)initWithX:(float)x AndY:(float)y;
- (void)update:(float)deltaTime;
- (void)hitSquirrel;
- (void)hitPlatform;
- (void)hitSpring;

@end
