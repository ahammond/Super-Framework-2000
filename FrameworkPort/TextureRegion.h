//
//  TextureRegion.h
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"

@interface TextureRegion : NSObject

@property (readonly) float u1, v1;
@property (readonly) float u2, v2;
@property (readonly) Texture *texture;

- (id)initWithTexture:(Texture *)theTexture AndX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height;

@end
