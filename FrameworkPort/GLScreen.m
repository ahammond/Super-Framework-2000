//
//  GLScreen.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLScreen.h"

@implementation GLScreen


- (id)initWithGameHelper:(GameHelper *)gameHelp AndGLGame:(GLGame *)game {
    self = [super init];
    
    if(self) {
        self->gameHelper = gameHelp;
        NSLog(@"GLScreen init width: %d height %d", [gameHelper width], [gameHelper height]);
        glGame = game;
    }
    
    return self;
}

- (void)update:(float)deltaTime {
    
}

- (void)present:(float)deltaTime {
    
}

- (void)pause {
    
}

- (void)resume {
    
}

- (void)dispose {
    
}

@end
