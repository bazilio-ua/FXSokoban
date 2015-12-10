//
//  FXIntermissionView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

@class FXPlayer;
@class FXStats;

@interface FXIntermissionView : FXView
@property (nonatomic, strong)	IBOutlet	UIButton	*nextLevelButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*mainMenuButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*highScoresButton;

@property (nonatomic, strong)	IBOutlet	UILabel		*nameLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*levelLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*movesLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*pushesLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*goalsLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*scoreLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*totalScoreLabel;

@property (nonatomic, strong)	FXPlayer	*player;
@property (nonatomic, strong)	FXStats		*stats;

- (void)fillWithPlayer:(FXPlayer *)player;
- (void)fillWithStats:(FXStats *)stats;

@end
