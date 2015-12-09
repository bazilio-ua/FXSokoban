//
//  FXViewController.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXPlayer;
@class FXLevel;
@class FXStats;

@interface FXViewController : UIViewController
@property (nonatomic, strong)	FXPlayer	*player;
@property (nonatomic, strong)	FXLevel		*level;
@property (nonatomic, strong)	FXStats		*stats;

@end
