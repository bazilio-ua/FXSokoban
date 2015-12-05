//
//  FXPlayer.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/20/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXStats.h"

@interface FXPlayer : FXStats
@property (nonatomic, copy)		NSString	*name;

+ (id)playerWithName:(NSString *)name;
- (id)initWithName:(NSString *)name;

+ (id)readDefaults;
- (void)writeDefaults;

@end
