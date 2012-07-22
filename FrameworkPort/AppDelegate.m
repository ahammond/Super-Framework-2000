//
//  AppDelegate.m
//  FrameworkPort
//
//  Created by Sage on 7/4/12.
//  Copyright (c) 2012 Sage. All rights reserved.
//

#import "AppDelegate.h"
#import "EAGLView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // called first after main
    
    NSLog(@"--- GLSpriteAppDelegate -- applicationDidFinishLaunching");
    window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];    
    glView = [[EAGLView alloc] initWithFrame:window.bounds];
    [window addSubview:glView];
    [window makeKeyAndVisible];

    [[UIApplication sharedApplication]setIdleTimerDisabled:YES];
    
    [glView setAnimationFrameInterval:1];
	//[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"--- GLSpriteAppDelegate -- applicationWillResignActive");
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"--- GLSpriteAppDelegate -- applicationDidBecomeActive");
    if(![glView isAnimating]) {
        [glView startAnimation];        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"--- GLSpriteAppDelegate -- applicationWillTerminate");
	[glView stopAnimation];
}

- (void) dealloc
{
    NSLog(@"--- GLSpriteAppDelegate -- GLSpriteAppDelegate dealloc");
	//[window release];
	//[glView release];
	
	//[super dealloc];
}

@end