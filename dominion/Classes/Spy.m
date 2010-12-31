//
//  Spy.m
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Spy.h"
#import "Player.h"
#import "Card.h"


@implementation Spy

@synthesize thePlayer, revealedCard;

- (NSString *) description {
	return @"1 Card, +1 Action, Each player (including you) reveals the top card of his deck and either discards it or puts it back, your choice.";
}

- (CardType) cardType {
	return ActionAttack;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {	
	self.thePlayer = player;
	player.actionCount++;
	[player drawFromDeck:1];
	return NO;
}

- (void) revealTopCardForPlayer: (Player *) player {
	NSMutableArray *cards = [player revealCardsFromDeck:1];
	if ([cards count] == 1) {
		Card *card = [cards objectAtIndex:0];
		[player.game setInfoLabel:[NSString stringWithFormat:@"%@ revealed %@.", player.name, card.name]];
		self.revealedCard = card;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:player.name message:[NSString stringWithFormat:@"Discard or put back %@?", card.name] delegate:self cancelButtonTitle:@"Put Back" otherButtonTitles:@"Discard", nil];
		[alert show];
		[alert release];
	} else {
		// nothing to reveal, we're done
		self.thePlayer = nil;
		self.revealedCard = nil;
		if (player == player.game.currentPlayer) { // since this "attack" also applies to the current player...
			[self.delegate actionFinished];
		} else {
			[self.delegate attackFinishedOnPlayer];
		}
	}

	// empty the array so we don't hold onto objects unnecessarily
	[cards removeAllObjects];
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
	self.thePlayer = player;
	[self revealTopCardForPlayer:player];
}

- (void) cardGained:(Card *)card {
	[self revealTopCardForPlayer:self.thePlayer];
}

- (void) couldNotDrawForPlayer:(Player *)player {
	[self revealTopCardForPlayer:self.thePlayer];
}

# pragma mark -
# pragma mark UIAlertViewDelegate implementation

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	// buttonIndex == 0 means put back card onto top of deck
	// buttonIndex == 1 means discard card
	if (buttonIndex == 0) {
		// really we don't have to do anything because we didn't remove the card, we just looked at it and remembered it
	} else {
		[self.thePlayer.hand removeCard:self.revealedCard];
		[self.thePlayer.discardDeck addCard:self.revealedCard];
	}
	self.thePlayer = nil;
	self.revealedCard = nil;
	[self.delegate attackFinishedOnPlayer];
}

@end
