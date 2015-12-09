//
//  FXGameViewController.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXViewController.h"

#import "FXLevelObserver.h"

@interface FXGameViewController : FXViewController <FXLevelObserver, UIAlertViewDelegate>

- (IBAction)onRestartButton:(id)sender;
- (IBAction)onMainMenuButton:(id)sender;

@end
