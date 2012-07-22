//
//  Vector2.h
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define TO_RADIANS (1 / 180.0) * M_PI;
//#define TO_DEGREES (1 / M_PI) * 180;

@interface Vector2 : NSObject {
}

@property (readwrite, assign) float x, y;

- (id)init;
- (id)initWithX:(float)x AndY:(float)y;
- (id)initWithVector2:(Vector2 *)vector2;
- (Vector2 *)cpy;
- (Vector2 *)set:(float)x AndY:(float)y;
- (Vector2 *)set:(Vector2 *)other;
- (Vector2 *)add:(float)x AndY:(float)y;
- (Vector2 *)add:(Vector2 *)other;
- (Vector2 *)sub:(float)x AndY:(float)y;
- (Vector2 *)sub:(Vector2 *)other;
- (Vector2 *)mul:(float)scalar;
- (float)len;
- (Vector2 *)nor;
- (float)angle;
- (Vector2 *)rotate:(float)angle;
- (float)dist:(Vector2 *)other;
- (float)dist:(float)x AndY:(float)y;
- (float)distSquared:(Vector2 *)other;
- (float)distSquared:(float)x AndY:(float)y;
+ (float)TO_RADIANS;
+ (float)TO_DEGREES;

@end
