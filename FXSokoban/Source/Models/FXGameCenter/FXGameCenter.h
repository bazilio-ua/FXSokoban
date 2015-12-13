//
//  FXGameCenter.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 12/13/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface FXGameCenter : NSObject
@property (nonatomic, copy) NSString *currentPlayerID;
@property (nonatomic, copy) NSString *currentPlayerAlias;
@property (nonatomic, assign, getter = isAuthenticationComplete) BOOL authenticationComplete;

+ (BOOL)isAvailable;

- (void)authenticateLocalPlayer;

@end
