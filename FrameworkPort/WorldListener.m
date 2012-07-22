//
//  WorldListener.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "WorldListener.h"

@implementation WorldListener

- (id)initWithGameHelper:(GameHelper *)gameHelp {
    self = [super init];
    if(self) {
        audioMan = [gameHelp audioMan];
    }
    return self;
}

- (void)jump {
    [audioMan playSound:@"jump"];
}

- (void)highJump {
    [audioMan playSound:@"highjump"];
}

- (void)hit {
    [audioMan playSound:@"hit"];
}

- (void)coin {
    [audioMan playSound:@"coin"];
}

@end
