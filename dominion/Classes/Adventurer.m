//
//  Adventurer.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Adventurer.h"
#import "Player.h"


@implementation Adventurer

@synthesize thePlayer, numTreasuresFound, revealedCards;

- (NSString *) description {
	return @"Reveal cards from your deck until you reveal 2 Treasure cards. Put those Treasure cards in your hand and discard the other revealed cards.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 6;
}

- (Boolean) takeAction: (Player *) player {
	self.thePlayer = player;
	player.gameDelegate = self;
	self.numTreasuresFound = 0;
	self.revealedCards = [[Deck alloc] init];
	[player drawFromDeck:1];
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained: (Card *) card {
	// is card a treasure card?
	if (card.isTreasure) {
		// it is, so keep it
		self.numTreasuresFound++;
		// have we found 2?
		if (self.numTreasuresFound == 2) {
			self.thePlayer = nil;
			self.numTreasuresFound = 0;
			self.revealedCards = nil;
			[self.delegate actionFinished];
			self.delegate = nil;
			return;
		}
	} else {
		// add revealed card to revealed deck
		[self.revealedCards addCard:card];
	}
	// draw again
	[self.thePlayer drawFromDeck:1];
}

- (void) couldNotDrawForPlayer:(Player *)player {
	// we're done
	[player.game actionFinished];
}

@end
