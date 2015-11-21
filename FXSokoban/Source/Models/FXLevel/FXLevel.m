//
//  FXLevel.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXLevel.h"

#import "FXLevelObserver.h"

#import "FXPosition.h"

@interface FXLevel ()
@property (nonatomic, strong)	NSDictionary	*cells;
@property (nonatomic, strong)	FXPosition		*playerPosition;
@property (nonatomic, assign)	NSUInteger		rows;
@property (nonatomic, assign)	NSUInteger		columns;
@property (nonatomic, assign)	NSUInteger		stones;

@end

@implementation FXLevel

#pragma mark -
#pragma mark Class Methods

+ (id)levelWithArray:(NSArray *)array {
	return [[self alloc] initWithArray:array];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithArray:(NSArray *)array {
	self = [super init];
	if (self) {
		
//		for (NSString *row in array) {
//			//<#statements#>
//		}
		
	}
	
	return self;
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

#pragma mark -
#pragma mark Private Methods

@end
