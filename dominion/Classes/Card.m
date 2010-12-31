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

- (NSString *) imageFileName {
	NSString *fileName = NSStringFromClass([self class]);
	fileName = [[fileName lowercaseString] stringByAppendingString:@".jpg"];
	return fileName;
}

- (NSUInteger) coins {
	[NSException raise:@"Unimplemented" format:@""];
	return 0;
}

- (NSUInteger) victoryPointsForPlayer: (Player *) player {
	return 0;
}

- (Boolean) isAction {
	return self.cardType == Action || self.cardType == ActionAttack;
}

- (Boolean) isAttack {
	return self.cardType == ActionAttack;
}

- (Boolean) isReaction {
	return self.cardType == ActionReaction;
}

- (Boolean) isTreasure {
	return self.cardType == Treasure;
}

- (Boolean) isVictory {
	// TODO probably give curses their own card type...
	return self.cardType == Victory && ![self.name isEqualToString:@"Curse"];
}

- (Boolean) isCurse {
	return self.cardType == Victory && [self.name isEqualToString:@"Curse"];
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

- (NSComparisonResult) compareUsingCost:(Card *) obj {
	if (self.cost < obj.cost) {
		return NSOrderedAscending;
	} else if (self.cost > obj.cost) {
		return NSOrderedDescending;
	} else {
		return [self.name compare:obj.name];
	}
}

- (void) dealloc {
	[super dealloc];
}

@end
