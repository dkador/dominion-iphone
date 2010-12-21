//
//  Feast.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Feast.h"
#import "Game.h"


@implementation Feast

- (NSString *) description {
	return @"Trash this card. Gain a card costing up to 5 Coins.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Game *) game {
	Card *card = [game.cleanupDeck peek];
	if ([card.name isEqual:@"Feast"]) { // feast has a weird interaction with throne room.
		// since we just took the action, the card's been moved to the cleanup deck
		card = [game.cleanupDeck draw];
		[game.trashDeck addCard:card];
	}
	[self.delegate gainCardCostingUpTo:5];
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
