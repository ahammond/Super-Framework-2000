//
//  Assets.h
//  FrameworkPort
//
//  Created by Sage on 7/6/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"
#import "TextureRegion.h"
#import "Animation.h"
#import "Font.h"

@class GLGame;

@interface Assets : NSObject

// super plane 2k assets
@property Texture *background, *items;
@property TextureRegion *backgroundRegion, *mainMenu, *pauseMenu, *ready, *gameOver, *highScoresREgion, *logo, *soundOn, *soundOff, *arrow, *pause, *spring, *castle, *planeHit, *platform;
@property Animation *coinAnim, *planeJump, *planeFall, *squirrelFly, *brakingPlatform;
@property Font *font;

// beachball assets
@property Texture *beachball;
@property TextureRegion *beachballRegion;

// cavemen assets
@property Texture *caveman;
@property Animation *cavemanWalk;


- (void)reload;
- (void)load:(GLGame *)game;

@end
