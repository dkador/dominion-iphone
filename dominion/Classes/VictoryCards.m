//
//  VictoryCards.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "VictoryCards.h"

static VictoryCards *sharedInstance = nil;

@implementation VictoryCards

# pragma mark -
# pragma mark Singleton methods

+ (VictoryCards *) sharedInstance {
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [[VictoryCards alloc] init];
		}
	}
	return sharedInstance;
}

+ (id) allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [super allocWithZone:zone];
			return sharedInstance;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

# pragma mark -
# pragma mark Property methods

- (Estate *) estate {
	if (!estate) {
		estate = [[[Estate alloc] init] autorelease];
	}
	return estate;
}

- (Duchy *) duchy {
	if (!duchy) {
		duchy = [[[Duchy alloc] init] autorelease];
	}
	return duchy;
}

- (Province *) province {
	if (!province) {
		province = [[[Province alloc] init] autorelease];
	}
	return province;
}

- (Curse *) curse {
	if (!curse) {
		curse = [[[Curse alloc] init] autorelease];
	}
	return curse;
}

@end
