//
//  MusicManager.m
//  FrameworkPort
//
//  Created by Sage on 7/13/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "MusicManager.h"

@implementation MusicManager

- (id)initWithMusic:(NSString *)resource {
    self = [super init];
    if(self) {
        NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:resource ofType:@"mp3"];
        NSURL *musicURL = [NSURL fileURLWithPath:musicFilePath];
        NSError *error;
        musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
        [musicPlayer setNumberOfLoops:-1];
        
        if (musicPlayer == nil) {
            NSLog(@"Music Manager Error: %@", error);
        }
        
    }
    return self;
}

- (void)play {
    [musicPlayer play];    
}

- (void)stop {
    [musicPlayer stop];
}

- (void)pause {
    
}

@end
