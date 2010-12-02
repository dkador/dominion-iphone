//
//  TreasureCards.m
//  dominion
//
//  Created by Daniel Kador on 11/29/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "TreasureCards.h"


static TreasureCards *sharedInstance = nil;

@implementation TreasureCards

@synthesize copper, silver, gold;

# pragma mark -
# pragma mark Singleton methods

+ (TreasureCards *) sharedInstance {
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [[TreasureCards alloc] init];
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

- (Copper *) copper {
	if (!copper) {
		copper = [[[Copper alloc] init] autorelease];
	}
	return copper;
}

- (Silver *) silver {
	if (!silver) {
		silver = [[[Silver alloc] init] autorelease];
	}
	return silver;
}

- (Gold *) gold {
	if (!gold) {
		gold = [[[Gold alloc] init] autorelease];
	}
	return gold;
}

@end
