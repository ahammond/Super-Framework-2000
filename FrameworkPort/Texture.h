//
//  Texture.h
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Texture : NSObject {
    NSString *textureFileName;
    GLuint textureId;
    int minFilter;
    int magFilter;
}

@property (readonly) int width, height;

- (id)initWithFileName:(NSString *)fileName;
- (void)load;
- (void)reload;
- (void)setFilters:(int)minimumFilter magniFilter:(int)magnifyFilter;
- (void)bind;
- (void)dispose;

@end
