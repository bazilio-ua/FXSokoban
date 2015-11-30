//
//  FXLevelObserver.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/20/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FXLevelObserver <NSObject>

@optional
- (void)levelDidChange:(id)level;
- (void)levelDidFinish:(id)level;

@end
