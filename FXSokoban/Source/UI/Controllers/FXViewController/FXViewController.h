//
//  FXViewController.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXStats;
@class FXPlayer;
@class FXLevel;

@interface FXViewController : UIViewController
@property (nonatomic, strong)	FXStats		*stats;
@property (nonatomic, strong)	FXPlayer	*player;
@property (nonatomic, strong)	FXLevel		*level;

@end
