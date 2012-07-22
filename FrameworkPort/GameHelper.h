//
//  GameHelper.h
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Assets.h"
#import "AccelerometerData.h"
#import "AudioManager.h"
#import "MusicManager.h"

@class GLGame;

@interface GameHelper : NSObject

@property (readwrite, assign) int width, height;
@property NSArray *touchEvents;
@property Assets *assets;
@property AccelerometerData *accelData;
@property AudioManager *audioMan;
@property MusicManager *musicMan;
@property (readwrite, assign) BOOL landscapeMode;

@end
