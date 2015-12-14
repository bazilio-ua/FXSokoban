//
//  FXGameCenter.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 12/13/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

#import "FXGameCenter.h"
#import "FXGameCenterObserver.h"

#import "FXMacros.h"

@implementation FXGameCenter

@dynamic authenticated;

#pragma mark -
#pragma mark Class Methods

+ (BOOL)isAvailable {
	static BOOL __available = NO;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		// Check for presence of GKLocalPlayer API.
		Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
		
		// The device must be running running iOS 6.0 or later.
		NSString *requiredSystemVersion = @"6.0";
		NSString *currentSystemVersion = [[UIDevice currentDevice] systemVersion];
		BOOL osVersionSupported = ([currentSystemVersion compare:requiredSystemVersion
														 options:NSNumericSearch] != NSOrderedAscending);
		__available = (gcClass && osVersionSupported);
	});
	
	return __available;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.currentPlayerID = nil;
	self.currentPlayerAlias = nil;
}

- (id)init {
	self = [super init];
	if (self) {
		// do init
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAuthenticated {
	return [[GKLocalPlayer localPlayer] isAuthenticated];
}

#pragma mark -
#pragma mark FXObservableObject overriden Methods

- (SEL)selectorForState:(NSUInteger)state {
	SEL selector = NULL;
	switch (state) {
		case kFXGameCenterDidAuthenticate:
			selector = @selector(gameCenterDidAuthenticate:);
			break;
			
		default:
			selector = [super selectorForState:state];
			break;
	}
	
	return selector;
}

#pragma mark -
#pragma mark Public Methods

- (void)authenticateLocalPlayer {
	GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
	
	FXWeakify(self);
	id authenticateHandler = ^(UIViewController *controller, NSError *error) {
		FXStrongify(self);
		if (!error) {
			if (controller) {
				[[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:controller
																										 animated:YES
																									   completion:nil];
			} else if (localPlayer.isAuthenticated) {
				if (!self.currentPlayerID || ![self.currentPlayerID isEqualToString:localPlayer.playerID]) {
					self.currentPlayerID = localPlayer.playerID; // player changed his ID
					self.currentPlayerAlias = localPlayer.alias;
				}
				
				self.state = kFXGameCenterDidAuthenticate;
			} else {
				// do else stuff
			}
		} else {
			NSLog(@"%@", [error localizedDescription]);
		}
	};
	
	[localPlayer setAuthenticateHandler:authenticateHandler];
}

@end
