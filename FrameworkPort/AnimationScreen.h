//
//  AnimationScreen.h
//  FrameworkPort
//
//  Created by Sage on 7/9/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "GLScreen.h"
#import "Vertices.h"
#import "Texture.h"
#import "FPSCounter.h"
#import "Camera2D.h"
#import "SpriteBatcher.h"
#import "TextureRegion.h"
#import "Animation.h"
#import "Rectangle.h"

@interface AnimationScreen : GLScreen {
    //Vertices *vertices;
    
    NSMutableArray *cavemen;
    FPSCounter *fpsCounter;
    Camera2D *camera;
    
    SpriteBatcher *batcher;
    Assets *assets;
//    Texture *texture;
//    Animation *walkAnim;
    NSArray *touchEvents;
    Rectangle *pauseBounds;
    Vector2 *touchPoint;
}

@end
