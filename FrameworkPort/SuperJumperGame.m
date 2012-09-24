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
