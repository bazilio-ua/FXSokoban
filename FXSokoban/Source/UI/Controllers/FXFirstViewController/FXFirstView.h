//
//  FXFirstView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

@interface FXFirstView : FXView
@property (nonatomic, strong)	IBOutlet	UIView		*firstView;
@property (nonatomic, strong)	IBOutlet	UIButton	*continueButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*aNewGameButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*highScoreButton;
@property (nonatomic, strong)	IBOutlet	UIButton	*quitButton;

@end
