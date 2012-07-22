//
//  Animation.m
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Animation.h"
#import <math.h>

@implementation Animation

- (id)initWithFrameDuartion:(float)theFrameDuration AndTextureRegions:(NSArray *)theKeyFrames {
    self = [super init];
    if(self) {
        self->frameDuration = theFrameDuration;
        self->keyFrames = theKeyFrames;
    }
    return self;
}

- (TextureRegion *)getKeyFrame:(float)stateTime AndMode:(int)mode {
    int frameNumber = (int)(stateTime / frameDuration);
    
    if(mode == ANIMATION_NONLOOPING) {
        frameNumber = MIN(([keyFrames count]-1), frameNumber);
    } else {
        frameNumber = frameNumber % [keyFrames count];
    }
    return [keyFrames objectAtIndex:frameNumber];
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"frameDuration: %f totalKeyFrames: %d", frameDuration, [keyFrames count]];
}

@end
