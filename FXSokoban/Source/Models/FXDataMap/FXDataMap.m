//
//  FXDataMap.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXDataMap.h"

#import "FXLevel.h"

static NSString * const kFXDataMapFileName		= @"datamap";
static NSString * const kFXDataMapFileType		= @"plist";
static NSString * const kFXDataMapRows			= @"Map Rows";

@interface FXDataMap ()
@property (nonatomic, strong)	NSArray		*dataMap;

- (id)loadDataMap;

@end

@implementation FXDataMap

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
	self = [super init];
	if (self) {
		self.dataMap = [self loadDataMap];
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)count {
	return [self.dataMap count];
}

- (FXLevel *)levelForNumber:(NSUInteger)number {
	FXLevel *level = nil;
	if (number < [self count]) {
		NSArray *array = self.dataMap[number][kFXDataMapRows];
		level = [FXLevel levelWithArray:array];
	}
	
	return level;
}

#pragma mark -
#pragma mark Private Methods

- (id)loadDataMap {
	NSString *path = [[NSBundle mainBundle] pathForResource:kFXDataMapFileName
													 ofType:kFXDataMapFileType];
//	NSURL *url = [NSURL fileURLWithPath:path];
//	NSData *data = [NSData dataWithContentsOfURL:url];
	NSData *data = [NSData dataWithContentsOfFile:path];
	
	NSError *error;
	NSPropertyListFormat format;
	id array = [NSPropertyListSerialization propertyListWithData:data
														 options:NSPropertyListImmutable
														  format:&format
														   error:&error];
	
	return array;
}

@end
