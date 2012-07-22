//
//  BeachBall.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "BeachBall.h"

@implementation BeachBall {
    
}

@synthesize x, y, angle, scale;

-(id)init {
    self = [super init];
    if(self) {
        //NSLog(@"--- BeachBall - init");
        x = arc4random() % 320;
        y = arc4random() % 480;
        dirX = 50;
        dirY = 50;
        scale = random() % 11 * 0.1;
        angle = arc4random() % 360;
        scaleup = YES;
    }
    return self;
}

-(void)update:(float)deltaTime {
    x = x + dirX * deltaTime;
    y = y + dirY * deltaTime;
    angle += 5;
    
    if (x < 0) {
        dirX = -dirX;
        x = 0;
    }
    if (x > 320) {
        dirX = -dirX;
        x = 320;
    }
    if (y < 0) {
        dirY = -dirY;
        y = 0;
    }
    if (y > 480) {
        dirY = -dirY;
        y = 480;
    }
    
    if (angle > 360)
        angle = 0;
    
    if (scaleup) {
        scale += 0.05;
        if (scale > 2) {
            scaleup = NO;
        }
    }
    
    if (!scaleup) {
        scale -= 0.05;
        if (scale < 0.5) {
            scaleup = YES;
        }
    }
    
}


@end
