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

- (Boolean) takeAction: (Game *) game {
	[self.delegate gainCardCostingUpTo:4];
	return YES;
}

- (void) cardGained {
	[self.delegate actionFinished];
}	

@end
