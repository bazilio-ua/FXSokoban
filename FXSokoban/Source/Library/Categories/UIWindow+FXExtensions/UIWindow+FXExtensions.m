//
//  UIWindow+FXExtensions.m
//  FXSokoban
//
//  Created by Basil Nikityuk on 9/15/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UIWindow+FXExtensions.h"

@implementation UIWindow (FXExtensions)

#pragma mark -
#pragma mark Class Methods

+ (id)window {
	return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
