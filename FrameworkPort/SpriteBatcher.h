//
//  SpriteBatcher.h
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertices.h"
#import "Texture.h"
#import "TextureRegion.h"

@interface SpriteBatcher : NSObject {
    GLfloat *verticesBuffer;
    int bufferIndex;
    Vertices *vertices;
    int numSprites;
}

- (id)initWithMaxSprites:(int)maxSprites;
- (void)beginBatch:(Texture *)texture;
- (void)endBatch;
- (void)drawSpriteWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height AndTextureRegion:(TextureRegion *)region;
- (void)drawSpriteWithX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height AndAngle:(float)angle AndTextureRegion:(TextureRegion *)region;

@end
