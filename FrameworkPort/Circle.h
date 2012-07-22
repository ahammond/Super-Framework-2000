//
//  Circle.h
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface Circle : NSObject

@property float radius;
@property Vector2 *center;

- (id)initWithX:(float)X AndY:(float)Y AndRadius:(float)Radius;

@end
