//
//  FXObservableObject.m
//  FXHomeWorks
//
//  Created by Basil Nikityuk on 8/9/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FXObservableObject.h"

#import "FXDispatch.h"

@interface FXObservableObject ()
@property (nonatomic, retain)	NSHashTable		*mutableObservers;
@property (nonatomic, assign)	BOOL			shouldNotify;

@end

@implementation FXObservableObject

@synthesize mutableObservers	= _mutableObservers;
@synthesize state				= _state;

@dynamic	observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableObservers = nil;
	
	[super dealloc];
}

- (id)init {
	self = [super init];
	if (self) {
		self.mutableObservers = [NSHashTable weakObjectsHashTable];
		self.shouldNotify = YES;
	}
	
	return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setState:(NSUInteger)state {
	[self setState:state withObject:nil];
}

- (void)setState:(NSUInteger)state withObject:(id)object {
	@synchronized(self) {
		if (state != _state) {
			_state = state;
		}
		
		if (self.shouldNotify) {
			[self notifyObserversWithSelector:[self selectorForState:state] withObject:object];
		}
	}
}

- (NSUInteger)state {
	@synchronized(self) {
		return _state;
	}
}

- (NSSet *)observers {
	@synchronized(self.mutableObservers) {
		return self.mutableObservers.setRepresentation;
	}
}

#pragma mark -
#pragma mark Public Methods

- (SEL)selectorForState:(NSUInteger)state {
	return NULL;
}

- (void)addObserver:(id)observer {
	@synchronized(self.mutableObservers) {
		[self.mutableObservers addObject:observer];
	}
}

- (void)removeObserver:(id)observer {
	@synchronized(self.mutableObservers) {
		[self.mutableObservers removeObject:observer];
	}
}

- (BOOL)containsObserver:(id)observer {
	@synchronized(self.mutableObservers) {
		return [self.mutableObservers containsObject:observer];
	}
}

- (void)notifyObserversWithSelector:(SEL)selector {
	[self notifyObserversWithSelector:selector withObject:nil];
}

- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object {
	[self notifyObserversWithSelector:selector withObject:self withObject:object];
}

- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object withObject:(id)anotherObject {
	for (id observer in self.mutableObservers) {
		if ([observer respondsToSelector:selector]) {
			FXDispatchSyncOnMainQueueWithBlock(^{
				[observer performSelector:selector withObject:object withObject:anotherObject];
			});
		}
	}
}

- (void)performBlock:(void (^)(void))block shouldNotify:(BOOL)shouldNotify {
	@synchronized(self) {
		BOOL notificationState = self.shouldNotify;
		self.shouldNotify = shouldNotify;
		if (block) {
			block();
		}
		
		self.shouldNotify = notificationState;
	}
}

@end
