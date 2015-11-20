//
//  FXGameView.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXView.h"

@interface FXGameView : FXView
@property (nonatomic, strong)	IBOutlet	UIView		*gameView;
@property (nonatomic, strong)	IBOutlet	UIButton	*undoButton;

@end
