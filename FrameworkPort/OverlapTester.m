//
//  OverlapTester.m
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "OverlapTester.h"

@implementation OverlapTester

+ (BOOL)overlapCircles:(Circle *)c1 AndCircle2:(Circle *)c2 {
    // float distance = [c1.center distSquared:c2.center]; //alt method
    float distance = [[c1 center]distSquared:[c2 center]];
    float radiusSum = [c1 radius] + [c2 radius];
    return distance <= radiusSum * radiusSum;
}

+ (BOOL)overlapRectangles:(Rectangle *)r1 AndRectangle2:(Rectangle *)r2 {
    if([[r1 lowerLeft]x] < [[r2 lowerLeft]x] + [r2 width] &&
       [[r1 lowerLeft]x] + [r1 width] > [[r2 lowerLeft]x] &&
       [[r1 lowerLeft]y] < [[r2 lowerLeft]y] + [r2 height] &&
       [[r1 lowerLeft]y] + [r1 height] > [[r2 lowerLeft]y]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)overlapCircleRectangle:(Circle *)c AndRectangle:(Rectangle *)r {
    float closetX = [[c center]x];
    float closetY = [[c center]y];
    
    if([[c center]x] < [[r lowerLeft]x]) {
        closetX = [[r lowerLeft]x];
    }
    else if([[c center]x] > [[r lowerLeft]x] + [r width]) {
        closetX = [[r lowerLeft]x] + [r width];
    }
    
    if([[c center]y] < [[r lowerLeft]y]) {
        closetY = [[r lowerLeft]y];
    }
    else if([[c center]y] > [[r lowerLeft]y] + [r height]) {
        closetY = [[r lowerLeft]y] + [r height];
    }
    return [[c center]distSquared:closetX AndY:closetY] < ([c radius] * [c radius]);
}

+ (BOOL)pointInCircle:(Circle *)c AndPoint:(Vector2 *)p {
    return [[c center]distSquared:p] < ([c radius] * [c radius]);
}

+ (BOOL)pointInCircle:(Circle *)c AndX:(float)X AndY:(float)Y {
    return [[c center]distSquared:X AndY:Y] < ([c radius] * [c radius]);
}

+ (BOOL)pointInRectangle:(Rectangle *)r AndPoint:(Vector2 *)p {
    return [[r lowerLeft]x] <= [p x] && [[r lowerLeft]x] + [r width] >= [p x] &&
           [[r lowerLeft]y] <= [p y] && [[r lowerLeft]y] + [r height] >= [p y];
}

+ (BOOL)pointInRectangle:(Rectangle *)r AndX:(float)X AndY:(float)Y {
    return [[r lowerLeft]x] <= X && [[r lowerLeft]x] + [r width] >= X &&
           [[r lowerLeft]y] <= Y && [[r lowerLeft]y] + [r height] >= Y;
}

@end
