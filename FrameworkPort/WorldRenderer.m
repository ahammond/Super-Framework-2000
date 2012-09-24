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
//  WorldRenderer.m
//  FrameworkPort
//
//  Created by Sage on 7/11/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "WorldRenderer.h"

@implementation WorldRenderer

- (id)initWithGameHelper:(id)gameHelp AndSpriteBatcher:(id)theBatcher AndWorld:(id)theWorld {
    self = [super init];
    if (self) {
        gameHelper = gameHelp;
        assets = [gameHelper assets];
        world = theWorld;
        cam = [[Camera2D alloc] initWithFrustrumWidth:FRUSTRUM_WIDTH AndFrustrumHeight:FRUSTRUM_HEIGHT AndGameHelper:gameHelper];
        batcher = theBatcher;
    }    
    return self;
}

- (void)render {
    // if the plane y is more than the cam y, move the cam up (y)
    if([[[world bob]position]y] > [[cam position]y]) {
        [[cam position]setY:([[[world bob]position]y])];
    }
    [cam setViewportAndMatrices];
    [self renderBackground];
    [self renderObjects];
}

- (void)renderBackground {
    [batcher beginBatch:[assets background]];
    [batcher drawSpriteWithX:[[cam position]x] AndY:[[cam position]y] AndWidth:FRUSTRUM_WIDTH AndHeight:FRUSTRUM_HEIGHT AndTextureRegion:[assets backgroundRegion]];
    [batcher endBatch];
}

- (void)renderObjects {
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [batcher beginBatch:[assets items]];
    [self renderBob];
    [self renderPlatforms];
    [self renderItems];
    [self renderSquirrels];
    [self renderCastle];
    [batcher endBatch];
    glDisable(GL_BLEND);
}

- (void)renderBob {
    TextureRegion *keyFrame;
    switch([[world bob]state]) {
        case BOB_STATE_FALL:
            keyFrame = [[assets planeFall]getKeyFrame:([[world bob]stateTime]) AndMode:ANIMATION_LOOPING];
            break;
        case BOB_STATE_JUMP:
            keyFrame = [[assets planeJump]getKeyFrame:([[world bob]stateTime]) AndMode:ANIMATION_LOOPING];
            break;
        case BOB_STATE_HIT:
        default:
            keyFrame = [assets planeHit];
    }
    float side = [[[world bob]velocity]x] < 0 ? -1 : 1;
    [batcher drawSpriteWithX:[[[world bob]position]x] AndY:[[[world bob]position]y] AndWidth:side * 1 AndHeight:1 AndTextureRegion:keyFrame];
}

- (void)renderPlatforms {
    int len = [[world platforms]count];
    for(int i=0; i<len; i++) {
        Platform *platform = [[world platforms]objectAtIndex:i];
        TextureRegion *keyFrame = [assets platform];
        if([platform state] == PLATFORM_STATE_PULVERIZING) {
            keyFrame = [[assets brakingPlatform]getKeyFrame:[platform stateTime] AndMode:ANIMATION_LOOPING];
        }
        [batcher drawSpriteWithX:[[platform position]x] AndY:[[platform position]y] AndWidth:2 AndHeight:0.5f AndTextureRegion:keyFrame];
    }
}

- (void)renderItems {
    // render coins, springs
    int len = [[world coins]count];
    for(int i=0; i<len; i++) {
        Coin *coin = [[world coins]objectAtIndex:i];
        TextureRegion *keyFrame = [[assets coinAnim]getKeyFrame:[coin stateTime] AndMode:ANIMATION_LOOPING];
        [batcher drawSpriteWithX:[[coin position]x] AndY:[[coin position]y] AndWidth:1 AndHeight:1 AndTextureRegion:keyFrame];
    }
    
    len = [[world springs]count];
    for(int i=0; i<len; i++) {
        Spring *spring = [[world springs]objectAtIndex:i];
        [batcher drawSpriteWithX:[[spring position]x] AndY:[[spring position]y] AndWidth:1 AndHeight:1 AndTextureRegion:[assets spring]];
    }
}

- (void)renderSquirrels {
    int len = [[world squirrels]count];
    for(int i=0; i<len; i++){
        Squirrel *squirrel = [[world squirrels]objectAtIndex:i];
        TextureRegion *keyFrame = [[assets squirrelFly]getKeyFrame:[squirrel stateTime] AndMode:ANIMATION_LOOPING];
        float side = [[squirrel velocity]x] < 0 ? -1 : 1;
        [batcher drawSpriteWithX:[[squirrel position]x] AndY:[[squirrel position]y] AndWidth:(side * 1) AndHeight:1 AndTextureRegion:keyFrame];
    }
}

- (void)renderCastle {
    Castle *castle = [world castle];
    [batcher drawSpriteWithX:[[castle position]x] AndY:[[castle position]y] AndWidth:2 AndHeight:2 AndTextureRegion:[assets castle]];
}

@end
