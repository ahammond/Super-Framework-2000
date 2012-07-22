//
//  Vertices.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Vertices.h"

@implementation Vertices

-(id)initWithData:(int)maximumVertices maxIndices:(int)maximumIndices hasColor:(BOOL)itHasColor itHasTexCoords:(BOOL)itHasTexCoords {
    self = [super init];
    if(self) {
        hasColor = itHasColor;
        hasTexCoords = itHasTexCoords;
        vertexSize = (2 + (hasColor?4:0) + (hasTexCoords?2:0)) * 4;
        
        // allocate memory for vertices and indices arrays
        // allocate maxVertices * vertexSize
        vertices = (GLfloat *)malloc(vertexSize * maximumVertices);
        if(maximumIndices > 0) {
            indices = (GLshort *)malloc(maximumIndices * sizeof(GLshort));
        } else {
            indices = nil;
        }
    }
    return self;
}

-(void)setVertices:(GLfloat *)theVertices offset:(int)offset length:(int)length {
    for(int i=offset, j=0; i<length; i++, j++) {
        vertices[j] = theVertices[i];
    }
}

-(void)setIndices:(GLshort *)theIndices offset:(int)offset length:(int)length {
    for(int i=offset, j=0; i<length; i++, j++) {
        indices[j] = theIndices[i];
    }
}


-(void)bind {
    int verticesPosition = 0;
    glEnableClientState(GL_VERTEX_ARRAY);
    glVertexPointer(2, GL_FLOAT, vertexSize, (vertices + verticesPosition));
    
    if(hasColor) {
        glEnableClientState(GL_COLOR_ARRAY);
        verticesPosition = 2;
        glColorPointer(4, GL_FLOAT, vertexSize, (vertices + verticesPosition));
    }
    
    if(hasTexCoords) {
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        if(hasColor) {
            verticesPosition = 6;
        } else {
            verticesPosition = 2;
        }
        glTexCoordPointer(2, GL_FLOAT, vertexSize, (vertices + verticesPosition));
    }
}

-(void)draw:(int)primitiveType offset:(int)offset numberVertices:(int)numVertices {
    if(indices != nil) {
        glDrawElements(primitiveType, numVertices, GL_UNSIGNED_SHORT, (indices + offset));
    } else {
        glDrawArrays(primitiveType, offset, numVertices);
    }
}

-(void)unbind {
    if(hasTexCoords) {
        glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    }
    if(hasColor) {
        glDisableClientState(GL_COLOR_ARRAY);
    }
}

@end
