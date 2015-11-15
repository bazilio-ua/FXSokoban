//
//  FXLevel.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXLevel : NSObject

+ (id)levelWithArray:(NSArray *)array;
- (id)initWithArray:(NSArray *)array;

@end
