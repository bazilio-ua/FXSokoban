//
//  FXGameCenterObserver.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 12/14/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FXGameCenterObserver <NSObject>

@optional
- (void)gameCenterDidAuthenticate:(id)object;

@end
