//
//  FPSCounter.h
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FPSCounter : NSObject {
    double startTime;
    int frames;
}

- (id)init;
- (void)logFrame;

@end
