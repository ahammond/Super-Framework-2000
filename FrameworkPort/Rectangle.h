//
//  Rectangle.h
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface Rectangle : NSObject

@property Vector2 *lowerLeft;
@property float width, height;

- (id)initWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height;

@end
