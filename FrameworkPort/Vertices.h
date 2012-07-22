//
//  Vertices.h
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Vertices : NSObject {
    BOOL hasColor;
    BOOL hasTexCoords;
    int vertexSize;
    GLfloat *vertices;
    GLshort *indices;
}

-(id)initWithData:(int)maximumVertices maxIndices:(int)maximumIndices hasColor:(BOOL)itHasColor itHasTexCoords:(BOOL)itHasTexCoords;
-(void)setVertices:(GLfloat *)theVertices offset:(int)offset length:(int)length;
-(void)setIndices:(GLshort *)theIndices offset:(int)offset length:(int)length;
-(void)bind;
-(void)draw:(int)primitiveType offset:(int)offset numberVertices:(int)numVertices;
-(void)unbind;

@end
