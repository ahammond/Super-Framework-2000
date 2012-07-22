//
//  Animation.h
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextureRegion.h"

#define ANIMATION_LOOPING 0
#define ANIMATION_NONLOOPING 1

@interface Animation : NSObject {
    float frameDuration;
    NSArray *keyFrames;
}

- (id)initWithFrameDuartion:(float)theFrameDuration AndTextureRegions:(NSArray *)theKeyFrames;
- (TextureRegion *)getKeyFrame:(float)stateTime AndMode:(int)mode;

@end
