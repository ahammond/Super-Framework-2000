//
//  MyGame.m
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "MyGame.h"
#import "BeachBallScreen.h"
#import "AnimationScreen.h"

@implementation MyGame

- (id)initWithGameHelper:(GameHelper *)gameHelp {
    self = [super init];
    
    if(self) {
        self->gameHelper = gameHelp;
        [gameHelper setAssets:[[Assets alloc] init]];
        [[gameHelper assets]load:self];
        NSLog(@"*** MyGame init GLgame width: %d height %d", [gameHelper width], [gameHelper height]);
        //glScreen = [[GLScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
        //glScreen = [[GLScreen alloc] initWithGameHelper:gameHelper];
    }
    return self;
}


/*
- (BeachBallScreen *)getStartScreen {
    //NSLog(@"MyGame width: %d height: %d", [gameHelper width], [gameHelper height]);
    BeachBallScreen *beachBallScreen = [[BeachBallScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    
    return beachBallScreen;
}
*/


- (AnimationScreen *)getStartScreen {
    //NSLog(@"MyGame width: %d height: %d", [gameHelper width], [gameHelper height]);
    //AnimationScreen *animationScreen = [[AnimationScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    AnimationScreen *animationScreen = [[AnimationScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    return animationScreen;
}

 
@end
