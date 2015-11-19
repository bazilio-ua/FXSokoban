//
//  FXFirstViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXFirstViewController.h"

#import "FXFirstView.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXFirstViewController, firstView, FXFirstView);

@interface FXFirstViewController ()

@end

@implementation FXFirstViewController

#pragma mark -
#pragma mark User Interactions

- (void)onContinueButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onNewGameButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onHighScoreButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onChangePlayerButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onQuitButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

@end
