//
//  FXStats.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 12/5/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXStats : NSObject
@property (nonatomic, assign)	NSUInteger	moves;
@property (nonatomic, assign)	NSUInteger	pushes;
@property (nonatomic, assign)	NSUInteger	goals;
@property (nonatomic, assign)	NSUInteger	score;

@end
