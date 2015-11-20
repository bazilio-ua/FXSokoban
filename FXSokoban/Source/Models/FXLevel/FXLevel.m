//
//  FXLevel.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXLevel.h"

#import "FXLevelObserver.h"

@implementation FXLevel

#pragma mark -
#pragma mark Class Methods

+ (id)levelWithArray:(NSArray *)array {
	return [[self alloc] initWithArray:array];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithArray:(NSArray *)array {
	return nil;
}

#pragma mark -
#pragma mark Overloaded Methods

- (SEL)selectorForState:(NSUInteger)state {
	SEL selector = NULL;
	switch (state) {
		case kFXLevelDidChange:
			selector = @selector(levelDidChange:);
			break;
			
		default:
			break;
	}
	
	return selector;
}

@end
