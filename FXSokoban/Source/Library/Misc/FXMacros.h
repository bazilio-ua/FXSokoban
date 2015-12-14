//
//  FXMacros.h
//  FXSokoban
//
//  Created by Basil Nikityuk on 11/12/15.
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

/*
 * base View generation macro
 */
#define FXDefineBaseViewProperty(propertyName, viewClass) \
@property (nonatomic, readonly)	viewClass *propertyName;

#define FXBaseViewGetterSynthesize(selector, viewClass) \
	- (viewClass *)selector { \
		if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
			return (viewClass *)self.view; \
		} \
		\
		return nil; \
	}

#define FXViewControllerBaseViewProperty(viewControllerClass, propertyName, viewClass) \
	@interface viewControllerClass (__##viewClass##_##propertyName) \
	FXDefineBaseViewProperty(propertyName, viewClass) \
	\
	@end \
	\
	@implementation viewControllerClass (__##viewClass##_##propertyName) \
	\
	@dynamic propertyName; \
	\
	FXBaseViewGetterSynthesize(propertyName, viewClass) \
	\
	@end



/*
 * weakify / strongify macro
 */
#define FXWeakify(object) \
	__weak __typeof(object) __FXWeakified_##object = object
//	id __weak __FXWeakified_##object = object

// you should only call this method after you called weakify for that same object
#define FXStrongify(object) \
	__strong __typeof(object) object = __FXWeakified_##object
//	id __strong object = __FXWeakified_##object

#define FXStrongifyAndReturnResultIfNil(object, result) \
	FXStrongify(object); \
	if (!object) { \
		return result; \
	}

#define FXEmpty

#define FXStrongifyAndReturnIfNil(object) \
	FXStrongifyAndReturnResultIfNil(object, FXEmpty)

#define FXStrongifyAndReturnNilIfNil(object) \
	FXStrongifyAndReturnResultIfNil(object, nil)
