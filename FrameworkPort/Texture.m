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
//  Texture.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Texture.h"

@implementation Texture;

@synthesize width, height;

- (id)initWithFileName:(NSString *)fileName {
    self = [super init];
    
    if(self) {
        textureFileName = fileName;
        [self load];
    }
    return self;
}

- (void)load {
    // setup textures
    CGImageRef spriteImage;
	CGContextRef spriteContext;
	GLubyte *spriteData;
	size_t	width_, height_;
    
	// Creates a Core Graphics image from an image file
	spriteImage = [UIImage imageNamed:textureFileName].CGImage;
	// Get the width and height of the image
	width_ = CGImageGetWidth(spriteImage);
	height_ = CGImageGetHeight(spriteImage);
	// Texture dimensions must be a power of 2. If you write an application that allows users to supply an image,
	// you'll want to add code that checks the dimensions and takes appropriate action if they are not a power of 2.
    
    // Allocated memory needed for the bitmap context
    spriteData = (GLubyte *) calloc(width_ * height_ * 4, sizeof(GLubyte));
    // Uses the bitmap creation function provided by the Core Graphics framework. 
    spriteContext = CGBitmapContextCreate(spriteData, width_, height_, 8, width_ * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    // After you create the context, you can draw the sprite image to the context.
    CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)width_, (CGFloat)height_), spriteImage);
    // You don't need the context at this point, so you need to release it to avoid memory leaks.
    CGContextRelease(spriteContext);
    
    // Use OpenGL ES to generate a name for the texture.
    glGenTextures(1, &textureId);
    
    // Bind the texture name.
    glBindTexture(GL_TEXTURE_2D, textureId);
    
    // Set the texture parameters to use a minifying filter and a linear filer (weighted average)
    //glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    //glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    //glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    [self setFilters:GL_NEAREST magniFilter:GL_NEAREST];
    
    // Specify a 2D texture image, providing the a pointer to the image data in memory
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width_, height_, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    width = (int)width_;
    height = (int)height_;
    
    // Release the image data
    free(spriteData);
    
}

- (void)bind {
    glBindTexture(GL_TEXTURE_2D, textureId);
}

- (void)reload {
    [self load];
    [self bind];
    [self setFilters:minFilter magniFilter:magFilter];
    glBindTexture(GL_TEXTURE_2D, 0);
}

- (void)setFilters:(int)minimumFilter magniFilter:(int)magnifyFilter {
    minFilter = minimumFilter;
    magFilter = magnifyFilter;
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, minFilter);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, magFilter);
}

- (void)dispose {
    glBindTexture(GL_TEXTURE_2D, textureId);
    glDeleteTextures(1, &textureId);
}

@end
