//
//  Gardens.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Gardens.h"
#import "Game.h"


@implementation Gardens

- (NSString *) description {
	return @"Variable, Worth 1 Victory for every 10 cards in your deck (rounded down).";
}

- (CardType) cardType {
	return Victory;
}

- (NSUInteger) cost {
	return 4;
}

- (NSUInteger) victoryPointsInGame:(Game *) game {
	int count = 0;
	int total = game.drawDeck.numCardsLeft;
	while (total >= 10) {
		count++;
		total -= 10;
	}
	return count;
}

@end
