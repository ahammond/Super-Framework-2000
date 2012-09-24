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
//  Assets.m
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "Assets.h"

@class GLGame;

@implementation Assets {

}


- (void)load:(GLGame *)game {
    NSLog(@"Loading Assets...");
    
    /*
    //NSLog(@"Loading Assets... beachball texture");
    // beachball assets
    _beachball = [[Texture alloc] initWithFileName:@"beachball.png"];
    _beachballRegion = [[TextureRegion alloc] initWithTexture:_beachball AndX:0 AndY:0 AndWidth:32 AndHeight:32];

    //NSLog(@"Loading Assets... caveman texture");
    // caveman assets
    _caveman = [[Texture alloc] initWithFileName:@"walkanim.png"];
    _cavemanWalk = [[Animation alloc] initWithFrameDuartion:0.2f
                                          AndTextureRegions:[[NSArray alloc]initWithObjects:
                                                                                    [[TextureRegion alloc] initWithTexture:_caveman AndX:0 AndY:0 AndWidth:64 AndHeight:64],
                                                                                    [[TextureRegion alloc] initWithTexture:_caveman AndX:64 AndY:0 AndWidth:64 AndHeight:64],
                                                                                    [[TextureRegion alloc] initWithTexture:_caveman AndX:128 AndY:0 AndWidth:64 AndHeight:64],
                                                                                    [[TextureRegion alloc] initWithTexture:_caveman AndX:192 AndY:0 AndWidth:64 AndHeight:64], nil]];
     
    */
    
    // load textures
    //NSLog(@"Loading Assets... background texture");
    _background = [[Texture alloc] initWithFileName:@"background.png"];
    //NSLog(@"Loading Assets... items texture");
    _items = [[Texture alloc] initWithFileName:@"items.png"];
    
    _backgroundRegion = [[TextureRegion alloc] initWithTexture:_background AndX:0 AndY:0 AndWidth:320 AndHeight:480];
    _mainMenu = [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:224 AndWidth:300 AndHeight:110];
    _pauseMenu = [[TextureRegion alloc] initWithTexture:_items AndX:224 AndY:128 AndWidth:192 AndHeight:96];
    _ready = [[TextureRegion alloc] initWithTexture:_items AndX:320 AndY:224 AndWidth:192 AndHeight:32];
    _gameOver = [[TextureRegion alloc] initWithTexture:_items AndX:352 AndY:256 AndWidth:160 AndHeight:96];
    _highScoresREgion = [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:257 AndWidth:300 AndHeight:(110/3)];
    _logo = [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:352 AndWidth:274 AndHeight:142];
    _soundOff = [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:0 AndWidth:64 AndHeight:64];
    _soundOn = [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:0 AndWidth:64 AndHeight:64];
    _arrow = [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:64 AndWidth:64 AndHeight:64];
    _pause = [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:64 AndWidth:64 AndHeight:64];
    
    _spring = [[TextureRegion alloc] initWithTexture:_items AndX:128 AndY:0 AndWidth:32 AndHeight:32];
    _castle = [[TextureRegion alloc] initWithTexture:_items AndX:128 AndY:64 AndWidth:64 AndHeight:64];

    //NSLog(@"Loading Assets... coinAnim");
    _coinAnim = [[Animation alloc] initWithFrameDuartion:0.2f AndTextureRegions:[[NSArray alloc]initWithObjects:
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:128 AndY:32 AndWidth:32 AndHeight:32],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:160 AndY:32 AndWidth:32 AndHeight:32],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:192 AndY:32 AndWidth:32 AndHeight:32],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:160 AndY:32 AndWidth:32 AndHeight:32], nil]];
    
    _planeJump = [[Animation alloc] initWithFrameDuartion:0.2f AndTextureRegions:[[NSArray alloc]initWithObjects:
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:128 AndWidth:32 AndHeight:32],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:32 AndY:128 AndWidth:32 AndHeight:32], nil]];

    _planeFall = [[Animation alloc] initWithFrameDuartion:0.2f AndTextureRegions:[[NSArray alloc]initWithObjects:
                                                                                  [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:128 AndWidth:32 AndHeight:32],
                                                                                  [[TextureRegion alloc] initWithTexture:_items AndX:96 AndY:128 AndWidth:32 AndHeight:32], nil]];

    _planeHit = [[TextureRegion alloc] initWithTexture:_items AndX:128 AndY:128 AndWidth:32 AndHeight:32];
    _squirrelFly = [[Animation alloc] initWithFrameDuartion:0.2f AndTextureRegions:[[NSArray alloc]initWithObjects:
                                                                                  [[TextureRegion alloc] initWithTexture:_items AndX:0 AndY:160 AndWidth:32 AndHeight:32],
                                                                                  [[TextureRegion alloc] initWithTexture:_items AndX:32 AndY:160 AndWidth:32 AndHeight:32], nil]];
    _platform = [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:160 AndWidth:64 AndHeight:16];
    _brakingPlatform = [[Animation alloc] initWithFrameDuartion:0.2f AndTextureRegions:[[NSArray alloc]initWithObjects:
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:160 AndWidth:64 AndHeight:16],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:176 AndWidth:64 AndHeight:16],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:192 AndWidth:64 AndHeight:16],
                                                                                 [[TextureRegion alloc] initWithTexture:_items AndX:64 AndY:208 AndWidth:64 AndHeight:16], nil]];

    //NSLog(@"Loading Assets... fonts");
    _font = [[Font alloc] initWithTexture:_items AndOffsetX:224 AndOffsetY:0 AndGlyphsPerRow:16 AndGlyphWidth:16 AndGlyphHeight:20];
    

    // music TODO goes here
    
    // sound TODO
    
    NSLog(@"... done");
}

- (void)reload {
    [[self background]reload];
    [[self items] reload];    
}

@end
