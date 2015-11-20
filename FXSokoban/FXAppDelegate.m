//
//  FXAppDelegate.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXAppDelegate.h"

#import "FXFirstViewController.h"

#import "FXLevelPack.h"

#import "UIWindow+FXExtensions.h"
#import "UIViewController+FXExtensions.h"
#import "UINavigationController+FXExtensions.h"

@implementation FXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIWindow *window = [UIWindow window];
	self.window = window;
	
	// Override point for customization after application launch.
	FXFirstViewController *controller = [FXFirstViewController controller];
	UINavigationController *navigationController = [UINavigationController navigationControllerWithRootViewController:controller];
	[navigationController setNavigationBarHidden:YES];
	
	window.rootViewController = navigationController;
	[window makeKeyAndVisible];
	
	// levels data singleton
	[FXLevelPack sharedInstance];
	
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
