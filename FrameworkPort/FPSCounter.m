//
//  FPSCounter.m
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "FPSCounter.h"

@implementation FPSCounter

- (id)init {
    self = [super init];
    if(self) {
        startTime = CFAbsoluteTimeGetCurrent();
    }
    return self;
}

- (void)logFrame {
    frames++;
    double currentTime = CFAbsoluteTimeGetCurrent();
    if((currentTime - startTime) >= 1) {
        NSLog(@"fps: %d", frames);
        frames = 0;
        startTime = CFAbsoluteTimeGetCurrent();
    }    
}

@end
