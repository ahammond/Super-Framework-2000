//
//  Font.h
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"
#import "TextureRegion.h"
#import "SpriteBatcher.h"

@interface Font : NSObject

@property int glyphWidth, glyphHeight;
@property Texture *texture;
@property NSMutableArray *glyphs;

- (id)initWithTexture:(Texture *)Texture AndOffsetX:(int)offsetX AndOffsetY:(int)offsetY AndGlyphsPerRow:(int)glyphsPerRow AndGlyphWidth:(int)glyphWidth AndGlyphHeight:(int)glyphHeight;
- (void)drawText:(SpriteBatcher *)batcher AndText:(NSString *)string AndX:(float)X AndY:(float)Y;

@end
