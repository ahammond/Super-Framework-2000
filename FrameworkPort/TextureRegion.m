//
//  TextureRegion.m
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "TextureRegion.h"

@implementation TextureRegion

@synthesize u1, v1, u2, v2, texture;

- (id)initWithTexture:(Texture *)theTexture AndX:(float)x AndY:(float)y AndWidth:(float)width AndHeight:(float)height {
    self = [super init];
    if(self) {
        u1 = x / [theTexture width];
        v1 = y / [theTexture height];
        u2 = u1 + width / [theTexture width];
        v2 = v1 + height / [theTexture height];
        self->texture = theTexture;
    }
    return self;
}

- (NSString *)description {
    return [[NSString alloc] initWithFormat:@"u1: %f v1: %f u2: %f v2: %f", u1, v1, u2, v2];
}

@end
