//
//  FXPosition.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXPosition.h"

@interface FXPosition ()
@property (nonatomic, assign)	NSInteger	x;
@property (nonatomic, assign)	NSInteger	y;

@end

@implementation FXPosition

#pragma mark -
#pragma mark Class Methods

+ (id)positionWithPointX:(NSInteger)x
				  pointY:(NSInteger)y
{
	return [[self alloc] initWithPointX:x
								 pointY:y];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithPointX:(NSInteger)x
			  pointY:(NSInteger)y
{
	self = [super init];
	if (self) {
		self.x = x;
		self.y = y;
	}
	
	return self;
}

#pragma mark -
#pragma mark NSCopying protocol

- (id)copyWithZone:(NSZone *)zone {
	return [[[self class] allocWithZone:zone] initWithPointX:self.x
													  pointY:self.y];
}

#pragma mark -
#pragma mark NSObject equality

- (NSUInteger)hash {
	return (self.x * 100 + self.y);
}

- (BOOL)isEqual:(FXPosition *)object {
	return [object isKindOfClass:[self class]] && self.x == object.x && self.y == object.y;
}

@end
