//
//  FXGameViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXGameViewController.h"

#import "FXGameView.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXGameViewController, gameView, FXGameView);

@interface FXGameViewController ()

@end

@implementation FXGameViewController

#pragma mark -
#pragma mark Initializations and Deallocations

#pragma mark -
#pragma mark User Interactions

- (void)onUndoButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

@end
