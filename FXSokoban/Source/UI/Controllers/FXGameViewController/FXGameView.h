//
//  FXGameView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

#import "FXLevelObserver.h"

@class FXLevel;
@class FXPlayer;
@class FXStats;

@interface FXGameView : FXView <FXLevelObserver>
@property (nonatomic, strong)	IBOutlet	UIView		*levelView;
@property (nonatomic, strong)	IBOutlet	UIButton	*undoButton;

@property (nonatomic, strong)	FXLevel		*level;
@property (nonatomic, strong)	FXPlayer	*player;
@property (nonatomic, strong)	FXStats		*stats;

- (void)setupFrameWithLevel:(FXLevel *)level;
- (void)processLevelWithLocation:(CGPoint)location;

@end
