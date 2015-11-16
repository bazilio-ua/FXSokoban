//
//  FXObservableObject.h
//  FXHomeWorks
//
//  Created by Basil Nikityuk on 8/9/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXObservableObject : NSObject
@property (nonatomic, readonly)	NSSet		*observers;
@property (nonatomic, assign)	NSUInteger	state;

- (void)setState:(NSUInteger)state withObject:(id)object;

// intended to be reloaded in subclasses
- (SEL)selectorForState:(NSUInteger)state;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (BOOL)containsObserver:(id)observer;

- (void)notifyObserversWithSelector:(SEL)selector;
- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object;
- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object withObject:(id)anotherObject;

- (void)performBlock:(void (^)(void))block shouldNotify:(BOOL)shouldNotify;

@end
