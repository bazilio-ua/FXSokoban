//
//  FXGameView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

#import "FXLevelObserver.h"

@class FXStats;
@class FXPlayer;
@class FXLevel;

@interface FXGameView : FXView <FXLevelObserver>
@property (nonatomic, strong)	IBOutlet	UIView		*levelView;
@property (nonatomic, strong)	IBOutlet	UIButton	*restartButton;
@property (nonatomic, strong)	IBOutlet	UILabel		*movesLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*pushesLabel;
@property (nonatomic, strong)	IBOutlet	UILabel		*goalsLabel;

@property (nonatomic, strong)	FXStats		*stats;
@property (nonatomic, strong)	FXPlayer	*player;
@property (nonatomic, strong)	FXLevel		*level;

- (void)fillWithPlayer:(FXPlayer *)player;
- (void)fillWithLevel:(FXLevel *)level;
- (void)setupFrameWithLevel:(FXLevel *)level;
- (void)processLevelWithLocation:(CGPoint)location;

@end
