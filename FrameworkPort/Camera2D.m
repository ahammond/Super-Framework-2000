//
//  Camera2D.m
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Camera2D.h"

//#define graphicsWidth 320
//#define graphicsHeight 480

@implementation Camera2D

- (id)initWithFrustrumWidth:(float)frustrumWidth AndFrustrumHeight:(float)frustrumHeight AndGameHelper:(GameHelper *)gameHelp {
    self = [super init];
    
    if (self) {
        gameHelper = gameHelp;
        _frustrumWidth = frustrumWidth;
        _frustrumHeight = frustrumHeight;
        _position = [[Vector2 alloc] initWithX:(frustrumWidth/2) AndY:(frustrumHeight/2)];
        _zoom = 1.0;
    }
    return self;
}

- (void)setViewportAndMatrices {
    //NSLog(@"--- Camera2D - width %d height %d", [gameHelper width], [gameHelper height]);
    glViewport(0, 0, [gameHelper width], [gameHelper height]);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    if ([gameHelper landscapeMode]) {
        glRotatef(90, 0, 0, 1);
    }
    glOrthof([_position x] - _frustrumWidth * _zoom / 2,
             [_position x] + _frustrumWidth * _zoom / 2,
             [_position y] - _frustrumHeight * _zoom / 2,
             [_position y] + _frustrumHeight * _zoom / 2,
             1, -1);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
}

- (void)touchToWorld:(Vector2 *)touch {
    if ([gameHelper landscapeMode]) {
        float tmpY = (1 - [touch x] / (float)[gameHelper width]) * _frustrumHeight * _zoom;
        float tmpX = (1 - [touch y] / (float)[gameHelper height]) * _frustrumWidth * _zoom;
        [touch set:tmpX AndY:tmpY];        
    } else {
        float tmpX = ([touch x] / (float)[gameHelper width]) * _frustrumWidth * _zoom;
        float tmpY = (1 - [touch y] / (float)[gameHelper height]) * _frustrumHeight * _zoom;
       [touch set:tmpX AndY:tmpY];
    }
    [[touch add:_position]sub:(_frustrumWidth*_zoom/2) AndY:(_frustrumHeight*_zoom/2)];
}

@end
