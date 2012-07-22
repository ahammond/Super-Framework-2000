//
//  OverlapTester.h
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Circle.h"
#import "Rectangle.h"
#import "Vector2.h"

@interface OverlapTester : NSObject

+ (BOOL)overlapCircles:(Circle *)c1 AndCircle2:(Circle *)c2;
+ (BOOL)overlapRectangles:(Rectangle *)r1 AndRectangle2:(Rectangle *)r2;
+ (BOOL)overlapCircleRectangle:(Circle *)c AndRectangle:(Rectangle *)r;
+ (BOOL)pointInCircle:(Circle *)c AndPoint:(Vector2 *)p;
+ (BOOL)pointInCircle:(Circle *)c AndX:(float)X AndY:(float)Y;
+ (BOOL)pointInRectangle:(Rectangle *)r AndPoint:(Vector2 *)p;
+ (BOOL)pointInRectangle:(Rectangle *)r AndX:(float)X AndY:(float)Y;

@end
