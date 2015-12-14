//
//  FXHighScoresView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/16/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

#import "FXGameCenterObserver.h"

@class FXGameCenter;

@interface FXHighScoresView : FXView <FXGameCenterObserver>
@property (nonatomic, strong)	IBOutlet	UIButton	*mainMenuButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*leaderboardButton;

@property (nonatomic, strong)	FXGameCenter			*gameCenter;

@end
