//
//  FXPosition.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXPosition : NSObject <NSCopying>
@property (nonatomic, readonly)	NSUInteger	row;
@property (nonatomic, readonly)	NSUInteger	column;

+ (id)positionWithRow:(NSUInteger)row column:(NSUInteger)column;
- (id)initWithRow:(NSUInteger)row column:(NSUInteger)column;

@end
