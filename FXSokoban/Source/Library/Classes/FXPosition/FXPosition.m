//
//  FXPosition.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXPosition.h"

@interface FXPosition ()
@property (nonatomic, assign)	NSUInteger	row;
@property (nonatomic, assign)	NSUInteger	column;

@end

@implementation FXPosition

#pragma mark -
#pragma mark Class Methods

+ (id)positionWithRow:(NSUInteger)row column:(NSUInteger)column {
	return [[self alloc] initWithRow:row column:column];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithRow:(NSUInteger)row column:(NSUInteger)column {
	self = [super init];
	if (self) {
		self.row = row;
		self.column = column;
	}
	
	return self;
}

#pragma mark -
#pragma mark NSCopying Protocol

- (id)copyWithZone:(NSZone *)zone {
	return [[[self class] allocWithZone:zone] initWithRow:self.row column:self.column];
}

#pragma mark -
#pragma mark NSObject equality

- (NSUInteger)hash {
	return (self.row * 100 + self.column);
}

- (BOOL)isEqual:(FXPosition *)object {
	return [object isKindOfClass:[self class]] && self.row == object.row && self.column == object.column;
}

@end
