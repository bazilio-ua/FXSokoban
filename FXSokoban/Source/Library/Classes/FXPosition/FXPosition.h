//
//  FXPosition.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXPosition : NSObject <NSCopying>
@property (nonatomic, readonly)	NSInteger	x;
@property (nonatomic, readonly)	NSInteger	y;

+ (id)positionWithPointX:(NSInteger)x
				  pointY:(NSInteger)y;
- (id)initWithPointX:(NSInteger)x
			  pointY:(NSInteger)y;

@end
