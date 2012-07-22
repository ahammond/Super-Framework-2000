//
//  Camera2D.h
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import "Vector2.h"
#import "GameHelper.h"

@interface Camera2D : NSObject {
    GameHelper *gameHelper;
}

@property float zoom, frustrumWidth, frustrumHeight;
@property Vector2 *position;

- (id)initWithFrustrumWidth:(float)frustrumWidth AndFrustrumHeight:(float)frustrumHeight AndGameHelper:(GameHelper*)gameHelp;
- (void)setViewportAndMatrices;
- (void)touchToWorld:(Vector2 *)touch;

@end
