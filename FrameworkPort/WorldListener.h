//
//  WorldListener.h
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameHelper.h"
#import "AudioManager.h"

@interface WorldListener : NSObject {
    AudioManager *audioMan;
}

- (id)initWithGameHelper:(GameHelper *)gameHelp;
- (void)jump;
- (void)highJump;
- (void)hit;
- (void)coin;

@end
