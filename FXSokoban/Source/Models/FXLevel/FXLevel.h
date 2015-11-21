//
//  FXLevel.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXObservableObject.h"

NS_ENUM(NSUInteger, FXLevelState) {
	kFXLevelDidChange
};

@interface FXLevel : FXObservableObject

+ (id)levelWithArray:(NSArray *)array;

- (id)initWithArray:(NSArray *)array;

@end
