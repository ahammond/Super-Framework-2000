//
//  Caveman.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Caveman.h"
#define WORLD_WIDTH 4.8 // was 3.2
#define WORLD_HEIGHT 3.2 // was 4.8

@implementation Caveman

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height {
    self = [super initWithX:x AndY:y AndWidth:width AndHeight:height];
    if(self) {
        float x = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * WORLD_WIDTH;
        float y = ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * WORLD_HEIGHT;
        [[self position]set:x AndY:y];
        float xvel = 0.5f;
        if( ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) > 0.5f) {
            xvel = -0.5f;
        }
        [[self velocity]set:xvel AndY:0];
        [self setWalkingTime:( ((arc4random()%RAND_MAX)/(RAND_MAX*1.0)) * 10 )];

    }
   return self;
}

- (void)update:(float)deltaTime {
    /*
     position.add(velocity.x * deltaTime, velocity.y * deltaTime);
     if(position.x < 0) position.x = WORLD_WIDTH;
     if(position.x > WORLD_WIDTH) position.x = 0;
     walkingTime += deltaTime;
     */
    [[self position]add:([[self velocity]x] * deltaTime) AndY:([[self velocity]y] * deltaTime)];
    if([[self position]x] < 0) {
        //NSLog(@"Rwrap - %f, %f", [[self position]x], [[self position]y]);
        [[self position]setX:WORLD_WIDTH];
    } else if([[self position]x] > WORLD_WIDTH) {
        //NSLog(@"Lwrap - %f, %f", [[self position]x], [[self position]y]);
        [[self position]setX:0];
    }
    float prevWalkingTime = [self walkingTime];
    [self setWalkingTime:(prevWalkingTime + deltaTime)];
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"position: %f,%f", [[self position]x], [[self position]y]];
}

@end
