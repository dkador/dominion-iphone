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
	// find other players, give them curse cards
	Game *game = player.game;
	Deck *curseDeck = game.curseDeck;
	NSArray *players = game.players;
	// first find the player to the right of current player (have to start with this one in case we run out of curses)
	NSUInteger startingPlayerIndex = 0;
	for (Player *aPlayer in players) {
		if (aPlayer == player) {
			startingPlayerIndex++;
			break;
		}
		startingPlayerIndex++;
	}
	if (startingPlayerIndex == [players count]) {
		startingPlayerIndex = 0; // wrap around if the current player is the last player
	}
	for (NSUInteger i=startingPlayerIndex; i<startingPlayerIndex+[players count]-1; i++) {
		NSUInteger realIndex = i % [players count];
		Player *aPlayer = [players objectAtIndex:realIndex];
		Card *curseCard = [curseDeck draw];
		if (curseCard) {
			[aPlayer.discardDeck addCard:curseCard];
		} else {
			// if we couldn't draw the curse card, the deck's empty. stop trying.
			break;
		}
	}
	
	[player drawFromDeck:2];
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	numCardsGained++;
	if (numCardsGained == 2) {
		[self.delegate actionFinished];
	}
}

- (void) couldNotDrawForPlayer:(Player *)player {
	[self.delegate actionFinished];
}

@end
