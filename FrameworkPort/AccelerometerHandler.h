//
//  AccelerometerHandler.h
//  FrameworkPort
//
//  Created by Sage on 7/7/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccelerometerHandler : NSObject <UIAccelerometerDelegate> {
    float accelX;
    float accelY;
    float accelZ;
}

- (float)getAccelX;
- (float)getAccelY;
- (float)getAccelZ;

@end
