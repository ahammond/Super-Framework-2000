//
//  GLGame.h
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLScreen.h"
#import "GameHelper.h"

typedef enum {
    Initialized,
    Running,
    Paused,
    Finished,
    Idle
} GLGameState;

@interface GLGame : NSObject {
    double startTime;
    GLScreen *glScreen;
    NSObject *stateChanged;
    GLGameState state;
    GameHelper *gameHelper;
}


// GLGame
- (id)initWithGameHelper:(GameHelper *)gameHelp;
- (void)drawFrame;
- (void)surfaceCreated;
- (void)pause;
- (void)resume;

// was in Game
- (void)setScreen:(GLScreen *)screen;
- (GLScreen *)getCurrentScreen;
- (GLScreen *)getStartScreen;

@end
