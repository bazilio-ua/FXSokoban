//
//  FXAppDelegate.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXAppDelegate.h"

#import "FXStartViewController.h"

#import "UIWindow+FXExtensions.h"
#import "UIViewController+FXExtensions.h"

@implementation FXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIWindow *window = [UIWindow window];
	self.window = window;
	
	// Override point for customization after application launch.
	FXStartViewController *controller = [FXStartViewController controller];
	
	window.rootViewController = controller;
	[window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	
}

- (void)applicationWillTerminate:(UIApplication *)application {
	
}

@end
