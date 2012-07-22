//
//  HelpScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/19/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLScreen.h"
#import "Camera2D.h"
#import "SpriteBatcher.h"
#import "Rectangle.h"
#import "Vector2.h"
#import "Texture.h"
#import "TextureRegion.h"
#import "Assets.h"
#import "TouchEvent.h"
#import "OverlapTester.h"
#import "GLGame.h"
#import "MainMenuScreen.h"

@interface HelpScreen : GLScreen {
    Camera2D *guiCam;
    SpriteBatcher *batcher;
    Rectangle *nextBounds;
    Vector2 *touchPoint;
    Texture *helpImage;
    TextureRegion *helpRegion;
    Assets *assets;
}

@end
