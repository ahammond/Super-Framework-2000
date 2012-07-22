//
//  Squirrel.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Squirrel.h"
#import "World.h"



@implementation Squirrel

- (id)initWithX:(float)x AndY:(float)y {
    self = [super initWithX:x AndY:y AndWidth:SQUIRREL_WIDTH AndHeight:SQUIRREL_HEIGHT];
    if(self) {
        [[self velocity]set:SQUIRREL_VELOCITY AndY:0];
    }
    return self;
}

- (void)update:(float)deltaTime {
    [[self position]add:([[self velocity]x]*deltaTime) AndY:([[self velocity]y]*deltaTime)];
    //[[[[self bounds]lowerLeft]set:[self position]]sub:(SQUIRREL_WIDTH / 2) AndY:(SQUIRREL_HEIGHT / 2)];
    
    //NSLog(@"squirrel velocity: %@ position: %@", [self velocity], [self position]);
    
    [[[self bounds]lowerLeft]set:[self position]];
    [[[self bounds]lowerLeft]sub:(SQUIRREL_WIDTH / 2) AndY:(SQUIRREL_HEIGHT / 2)];
    
    if([[self position]x] < SQUIRREL_WIDTH / 2) {
        [[self position]setX:(SQUIRREL_WIDTH / 2)];
        [[self velocity]setX:SQUIRREL_VELOCITY];
    }
    if([[self position]x] > WORLD_WIDTH - SQUIRREL_WIDTH / 2) {
        [[self position]setX:(WORLD_WIDTH - SQUIRREL_WIDTH / 2)];
        [[self velocity]setX:-SQUIRREL_VELOCITY];
    }
    _stateTime += deltaTime;
}

@end
