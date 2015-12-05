//
//  FXViewController.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXViewController.h"

#import "FXLevel.h"

@interface FXViewController ()

@end

@implementation FXViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.player = nil;
	self.level = nil;
	self.stats = nil;
}

#pragma mark -
#pragma mark Accessors

- (void)setLevel:(FXLevel *)level {
	if (_level != level) {
		[_level removeObserver:self];
		_level = level;
		[_level addObserver:self];
	}
}

@end
