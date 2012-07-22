//
//  MusicManager.h
//  FrameworkPort
//
//  Created by Sage on 7/13/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicManager : NSObject {
    AVAudioPlayer *musicPlayer;
}

- (id)initWithMusic:(NSString *)resource;
- (void)play;
- (void)stop;
- (void)pause;

@end
