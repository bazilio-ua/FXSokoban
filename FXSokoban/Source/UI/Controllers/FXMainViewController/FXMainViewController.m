//
//  FXMainViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXMainViewController.h"
#import "FXMainView.h"

#import "FXGameViewController.h"

#import "FXPlayer.h"
#import "FXLevelPack.h"

#import "UIViewController+FXExtensions.h"

#import "FXMacros.h"

FXViewControllerBaseViewProperty(FXMainViewController, mainView, FXMainView);

@interface FXMainViewController ()

- (void)setupPlayer;
- (void)pushGameViewController;

@end

@implementation FXMainViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self setupPlayer];
	}
	
	return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

#pragma mark -
#pragma mark User Interactions

- (void)onContinueButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onNewGameButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	[self pushGameViewController];
}

- (void)onHighScoreButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

- (void)onQuitButton:(id)sender {
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
}

#pragma mark -
#pragma mark Private Methods

- (void)setupPlayer {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	NSDictionary *dictionary = [defaults dictionaryForKey:@"player"];
	if (dictionary) {
		NSString *name = [dictionary objectForKey:@"name"];
		if ([name length]) {
			FXPlayer *player = [FXPlayer playerWithName:name];
			if (player) {
				player.level = [[dictionary valueForKey:@"level"] integerValue];
				player.moves = [[dictionary valueForKey:@"moves"] integerValue];
				player.pushes = [[dictionary valueForKey:@"pushes"] integerValue];
				player.goals = [[dictionary valueForKey:@"goals"] integerValue];
				player.score = [[dictionary valueForKey:@"score"] integerValue];
				
				self.level = [[FXLevelPack sharedInstance] levelAtIndex:player.level];
				self.player = player;
			}
		}
	}
	
	if (!self.player) {
		self.level = [[FXLevelPack sharedInstance] levelAtIndex:0];
	}
}

- (void)pushGameViewController {
	FXGameViewController *controller = [FXGameViewController controller];
	controller.player = self.player;
	controller.level = self.level;
	
	[self.navigationController pushViewController:controller animated:NO];
}

@end
