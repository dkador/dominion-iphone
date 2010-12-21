//
//  Workshop.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Workshop.h"


@implementation Workshop

- (NSString *) description {
	return @"Gain a card costing up to 4 Coins";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 3;
}

- (Boolean) takeAction: (Player *) player {
	[self.delegate gainCardCostingUpTo:4];
	return YES;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained {
	[self.delegate actionFinished];
}	

- (void) couldNotDrawInGame:(Game *)game {
	[self.delegate actionFinished];
}

@end
