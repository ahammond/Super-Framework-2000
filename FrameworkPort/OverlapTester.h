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
//  OverlapTester.h
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Circle.h"
#import "Rectangle.h"
#import "Vector2.h"

@interface OverlapTester : NSObject

+ (BOOL)overlapCircles:(Circle *)c1 AndCircle2:(Circle *)c2;
+ (BOOL)overlapRectangles:(Rectangle *)r1 AndRectangle2:(Rectangle *)r2;
+ (BOOL)overlapCircleRectangle:(Circle *)c AndRectangle:(Rectangle *)r;
+ (BOOL)pointInCircle:(Circle *)c AndPoint:(Vector2 *)p;
+ (BOOL)pointInCircle:(Circle *)c AndX:(float)X AndY:(float)Y;
+ (BOOL)pointInRectangle:(Rectangle *)r AndPoint:(Vector2 *)p;
+ (BOOL)pointInRectangle:(Rectangle *)r AndX:(float)X AndY:(float)Y;

@end
