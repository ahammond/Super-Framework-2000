//
//  AccelerometerHandler.m
//  FrameworkPort
//
//  Created by Sage on 7/7/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "AccelerometerHandler.h"

// CONSTANTS
#define kAccelerometerFrequency		100.0 // Hz
#define kFilteringFactor			0.1

@implementation AccelerometerHandler

- (id)init {
    self = [super init];
    
    if (self) {
        //Configure and start accelerometer
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        
    }
    return self;
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    //debug
    //NSLog(@"accel x:%f y:%f z:%f", [acceleration x], [acceleration y], [acceleration z]);    
    accelX = [acceleration x];
    accelY = [acceleration y];
    accelZ = [acceleration z];
}

- (float)getAccelX {
    return accelX;
}

- (float)getAccelY {
    return accelY;
}

- (float)getAccelZ {
    return accelZ;
}

@end
