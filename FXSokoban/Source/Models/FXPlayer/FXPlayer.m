//
//  FXPlayer.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/20/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXPlayer.h"

@implementation FXPlayer

#pragma mark -
#pragma mark Class Methods

+ (id)playerWithName:(NSString *)name {
	return [[self alloc] initWithName:name];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithName:(NSString *)name {
	self = [super init];
	if (self) {
		self.name = name;
	}
	
	return self;
}

@end
