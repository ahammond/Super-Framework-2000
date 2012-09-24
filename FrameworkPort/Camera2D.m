// Copyright (c) 2012, Sage Herron <sage@barnhousetech.com>
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. All advertising materials mentioning features or use of this software
//    must display the following acknowledgement:
//    This product includes software developed by the <organization>.
// 4. Neither the name of the <organization> nor the
//    names of its contributors may be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
