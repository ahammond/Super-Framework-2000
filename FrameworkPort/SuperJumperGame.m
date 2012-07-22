//
//  DogfightGame.m
//  FrameworkPort
//
//  Created by Sage on 7/10/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "SuperJumperGame.h"
#import "MainMenuScreen.h"
//#import "AnimationScreen.h"
//#import "BeachBallScreen.h"

@implementation SuperJumperGame

- (id)initWithGameHelper:(GameHelper *)gameHelp {
    self = [super init];
    
    if(self) {
        self->gameHelper = gameHelp;
        [gameHelper setAssets:[[Assets alloc] init]];
        [[gameHelper assets]load:self];
        
        // load sounds
        [[gameHelper audioMan]loadFile:@"coin" doesLoop:NO];
        [[gameHelper audioMan]loadFile:@"click" doesLoop:NO];
        [[gameHelper audioMan]loadFile:@"highjump" doesLoop:NO];
        [[gameHelper audioMan]loadFile:@"jump" doesLoop:NO];
        [[gameHelper audioMan]loadFile:@"hit" doesLoop:NO];

        [[gameHelper musicMan]play];
        
        NSLog(@"*** DogfightGame init GLgame width: %d height %d", [gameHelper width], [gameHelper height]);
        //glScreen = [[GLScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    }
    
    return self;
}

- (GLScreen *)getStartScreen {
    //NSLog(@"MyGame width: %d height: %d", [gameHelper width], [gameHelper height]);
    MainMenuScreen *mainMenuScreen = [[MainMenuScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    //AnimationScreen *animationScreen = [[AnimationScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    //BeachBallScreen *beachBallScreen = [[BeachBallScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    return mainMenuScreen;
}


@end
