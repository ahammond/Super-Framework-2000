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
