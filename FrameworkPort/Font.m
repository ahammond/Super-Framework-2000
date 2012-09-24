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
//  Font.m
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#define MAX_GLYPHS 96
#import "Font.h"

@implementation Font

- (id)initWithTexture:(Texture *)theTexture AndOffsetX:(int)offsetX AndOffsetY:(int)offsetY AndGlyphsPerRow:(int)glyphsPerRow AndGlyphWidth:(int)glyphWidth AndGlyphHeight:(int)glyphHeight {
    self = [super init];
    if(self) {
        NSLog(@"Loading font... init");
        _glyphs = [[NSMutableArray alloc] initWithCapacity:MAX_GLYPHS];
//        for(int k=0; k<[_glyphs count]; k++)
//            [_glyphs insertObject:NULL atIndex:1];
        _texture = theTexture;
        _glyphWidth = glyphWidth;
        _glyphHeight = glyphHeight;
        int x = offsetX;
        int y = offsetY;
        for(int i=0; i<MAX_GLYPHS; i++) {
            TextureRegion *glyph = [[TextureRegion alloc] initWithTexture:_texture AndX:x AndY:y AndWidth:_glyphWidth AndHeight:_glyphWidth];
            //NSLog(@"Loading font... setting glyph at index: %d", i);
            //[_glyphs setObject:glyph atIndexedSubscript:i];
            [_glyphs insertObject:glyph atIndex:i];
            x += _glyphWidth;
            if(x == offsetX + glyphsPerRow * _glyphWidth) {
                x = offsetX;
                y += _glyphHeight;
            }
        }
    }
    return self;
}

- (void)drawText:(SpriteBatcher *)batcher AndText:(NSString *)string AndX:(float)X AndY:(float)Y {
    int len = [string length];
    for(int i=0; i<len; i++) {
        int c = [string characterAtIndex:i] - ' ';
        if(c < 0 || c > [_glyphs count] - 1)
            continue;
        
        TextureRegion *glyph = _glyphs[c];
        [batcher drawSpriteWithX:X AndY:Y AndWidth:_glyphWidth AndHeight:_glyphHeight AndTextureRegion:glyph];
        X += _glyphWidth;
    }
}

@end
