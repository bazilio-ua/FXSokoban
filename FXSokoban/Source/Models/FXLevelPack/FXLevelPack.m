//
//  FXLevelPack.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXLevelPack.h"

#import "FXLevel.h"

static NSString * const kFXLevelPackFileName		= @"levelpack";
static NSString * const kFXLevelPackFileType		= @"plist";
static NSString * const kFXLevelPackRows			= @"Level Rows";

@interface FXLevelPack ()
@property (nonatomic, strong)	NSArray		*levels;

- (id)loadLevelPack;

@end

@implementation FXLevelPack

#pragma mark -
#pragma mark Class Methods

+ (FXLevelPack *)sharedInstance {
	static FXLevelPack *__levelPack = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		__levelPack = [[self alloc] init];
	});
	
	return __levelPack;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
	self = [super init];
	if (self) {
		self.levels = [self loadLevelPack];
	}
	
	return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)count {
	return [self.levels count];
}

- (FXLevel *)levelAtIndex:(NSUInteger)index {
	FXLevel *level = nil;
	if (index < [self count]) {
		NSArray *array = self.levels[index][kFXLevelPackRows];
		level = [FXLevel levelWithArray:array];
	}
	
	return level;
}

#pragma mark -
#pragma mark Private Methods

- (id)loadLevelPack {
	NSString *path = [[NSBundle mainBundle] pathForResource:kFXLevelPackFileName
													 ofType:kFXLevelPackFileType];
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
