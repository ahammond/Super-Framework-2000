//
//  BeachBall.h
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BeachBall : NSObject {
    float x, y;
    float dirX, dirY;
    int angle;
    float scale;
    BOOL scaleup;
}

@property float x;
@property float y;
@property float scale;
@property int angle;

- (id)init;
- (void)update:(float)deltaTime;

@end
