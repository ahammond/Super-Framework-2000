//
//  TouchEvent.h
//  FrameworkPort
//
//  Created by Sage on 7/8/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TouchBegin,
    TouchMove,
    TouchEnd,
    TouchCancel
} TouchType;

@interface TouchEvent : NSObject

@property (readonly) float x, y;
@property (readonly) int touchNumber;
@property (readonly) TouchType touchType;

- (id)initWithType:(TouchType)touchType TouchNumber:(int)touches AndX:(float)x AndY:(float)y;


@end
