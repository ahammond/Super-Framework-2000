//
//  MainMenuScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/10/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLScreen.h"
#import "Camera2D.h"
#import "Rectangle.h"
#import "Vector2.h"
#import "SpriteBatcher.h"
#import "GLGame.h"

@interface MainMenuScreen : GLScreen {
    Camera2D *guiCam;
    SpriteBatcher *batcher;
    Rectangle *soundBounds;
    Rectangle *playBounds;
    Rectangle *highscoresBounds;
    Rectangle *helpBounds;
    Vector2 *touchPoint;
    Assets *assets;
    
    NSArray *touchEvents;
}

@end
