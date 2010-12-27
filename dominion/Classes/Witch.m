//
//  Witch.m
//  dominion
//
//  Created by Daniel Kador on 12/23/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Witch.h"
#import "Player.h"
#import "Game.h"


@implementation Witch

@synthesize numCardsGained;

- (NSString *) description {
	return @"+2 Cards. Each other player gains a curse card.";
}

- (CardType) cardType {
	return ActionAttack;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Player *) player {	
	[player drawFromDeck:2];
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
	Card *curseCard = [player.game.curseDeck draw];
	if (curseCard) {
		[player.discardDeck addCard:curseCard];
	} 
}

- (void) cardGained:(Card *)card {
	self.numCardsGained++;
	if (self.numCardsGained == 2) {
		self.numCardsGained = 0;
		[self.delegate actionFinished];
	}
}

- (void) couldNotDrawForPlayer:(Player *)player {
	self.numCardsGained = 0;
	[self.delegate actionFinished];
}

@end
