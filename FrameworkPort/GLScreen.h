//
//  GLScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameHelper.h"

@interface GLScreen : NSObject {
    GameHelper *gameHelper;
    GLGame *glGame;
}

//- (id)initWithGameHelper:(GameHelper *)gameHelp;
- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game;
- (void)update:(float)deltaTime;
- (void)present:(float)deltaTime;
- (void)pause;
- (void)resume;
- (void)dispose;

@end
