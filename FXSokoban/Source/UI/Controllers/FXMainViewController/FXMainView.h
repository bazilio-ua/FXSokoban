//
//  FXMainView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

@class FXPlayer;

@interface FXMainView : FXView
@property (nonatomic, strong)	IBOutlet	UIButton	*continueButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*aNewGameButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*highScoresButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*quitButton;

@property (nonatomic, strong)	FXPlayer	*player;

- (void)fillWithPlayer:(FXPlayer *)player;

@end
