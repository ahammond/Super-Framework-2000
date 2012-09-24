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
