//
//  FXViewController.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FXLevel;
@class FXPlayer;

@interface FXViewController : UIViewController
@property (nonatomic, strong)	FXLevel		*level;
@property (nonatomic, strong)	FXPlayer	*player;

@end
