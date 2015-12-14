//
//  FXGameCenter.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 12/13/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXObservableObject.h"

NS_ENUM(NSUInteger, FXGameCenterState) {
	kFXGameCenterDidAuthenticate
};

@interface FXGameCenter : FXObservableObject
@property (nonatomic, copy) NSString *currentPlayerID;
@property (nonatomic, copy) NSString *currentPlayerAlias;
@property (nonatomic, readonly, getter = isAuthenticated)			BOOL	authenticated;

+ (BOOL)isAvailable;

- (void)authenticateLocalPlayer;

@end
