//
//  Card.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Card.h"


@implementation Card

@dynamic description, cardType, cost;

- (NSString *) name {
	return NSStringFromClass([self class]);
}

- (NSUInteger) coins {
	[NSException raise:@"Unimplemented" format:@""];
	return 0;
}

- (NSUInteger) victoryPointsInGame: (Game *) game {
	return 0;
}

- (NSComparisonResult) compare:(Card *) obj {
	if (self.cardType < obj.cardType) {
		return NSOrderedAscending;
	} else if (self.cardType > obj.cardType) {
		return NSOrderedDescending;
	} else {
		if (self.cost < obj.cost) {
			return NSOrderedAscending;
		} else if (self.cost > obj.cost) {
			return NSOrderedDescending;
		} else {
			return [self.name compare:obj.name];
		}
	}
}

- (void) dealloc {
	[super dealloc];
}

@end