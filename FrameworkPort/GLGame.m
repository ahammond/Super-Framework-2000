// Copyright (c) 2012, Sage Herron <sage@barnhousetech.com>
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software
//    must display the following acknowledgement:
//    This product includes software developed by the <organization>.
// 4. Neither the name of the <organization> nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
