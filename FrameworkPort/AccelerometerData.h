//
//  AccelerometerEvent.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccelerometerData : NSObject

@property float accelX, accelY, accelZ;

- (void)setAccelX:(float)X setAccelY:(float)Y setAccelZ:(float)Z;

@end
