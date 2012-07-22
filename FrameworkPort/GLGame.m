//
//  GLGame.m
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLGame.h"
#import "TouchEvent.h"

@implementation GLGame
- (id)initWithGameHelper:(GameHelper *)gameHelp {
    self = [super init];
    
    if(self) {
        self->gameHelper = gameHelp;
        
        //NSLog(@"init GLgame width: %d height %d", [gameHelper width], [gameHelper height]);
        glScreen = [[GLScreen alloc] initWithGameHelper:gameHelper AndGLGame:self];
    }
    
    return self;
}

- (void)drawFrame {
    GLGameState drawFrameState;
    
    @synchronized(self) {
        drawFrameState = state;
    }
    
    // Running
    if(state == Running) {
        double currentTime = CFAbsoluteTimeGetCurrent();
        float deltaTime = currentTime - startTime;
        //NSLog(@"deltaTime: %f", deltaTime);
        startTime = CFAbsoluteTimeGetCurrent();
        [glScreen update:deltaTime];
        [glScreen present:deltaTime];
        
        /*
        // test code for events
        if ([gameHelper touchEvents]) {
            for(TouchEvent *event in [gameHelper touchEvents]) {
                NSLog(@"--- GLGame TouchEvents - %@", event);
            }
        } */
    }
    
    // Paused
    if(state == Paused) {
        [glScreen pause];
        @synchronized(self) {
            state = Idle;
        }
    }
    
    
    // Finished
    if (state == Finished) {
        [glScreen pause];
        [glScreen dispose];
        @synchronized(self) {
            state = Idle;
        }
    }
    
    
}

- (void)surfaceCreated {
    NSLog(@"--- GLGame - surfaceCreated");
    @synchronized(self) {
        if (state == Initialized) {
            glScreen = [self getStartScreen];
        }
        state = Running;
        [glScreen resume];
        startTime = CFAbsoluteTimeGetCurrent();
    }
}

- (void)pause {
    NSLog(@"--- GLGame - pause");
    @synchronized(self) {
        state = Paused;
    }
}

- (void)resume {
    NSLog(@"--- GLGame - resume");
    state = Running;
    startTime = CFAbsoluteTimeGetCurrent();
}

- (void)setScreen:(GLScreen *)screen {
    NSLog(@"--- GLGame - setScreen");
    if(screen == nil) {
        NSLog(@"Screen must not be nil");
    }
    
    [glScreen pause];
    [glScreen dispose];
    [screen resume];
    [screen update:0];
    glScreen = screen;
}

- (GLScreen *)getCurrentScreen {
    NSLog(@"--- GLGame - getCurrentScreen");
    return glScreen;
}

// must implement in subclass
- (GLScreen *)getStartScreen {
    NSLog(@"--- GLGame - getStartScreen");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

// for debug, return state, startTime
- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"GLGame state: %d deltaTime: %f", state, startTime ];
}

@end
