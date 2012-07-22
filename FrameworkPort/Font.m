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
