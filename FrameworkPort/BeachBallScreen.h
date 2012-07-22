//
//  BeachBallScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/5/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLScreen.h"
#import "Vertices.h"
#import "Texture.h"
#import "FPSCounter.h"
#import "Camera2D.h"
#import "SpriteBatcher.h"
#import "TextureRegion.h"

@interface BeachBallScreen : GLScreen {
    Vertices *vertices;
    
    NSMutableArray *beachballs;
    FPSCounter *fpsCounter;
    Camera2D *camera2d;

    SpriteBatcher *spriteBatcher;
    
    //TextureRegion *beachBallRegion;
    //Texture *texture;
    Assets *assets;
    
    NSArray *touchEvents;
}



@end
