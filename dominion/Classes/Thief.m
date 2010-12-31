//
//  Thief.m
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Thief.h"
#import "Game.h"
#import "Player.h"
#import "Deck.h"
#import "Card.h"
#import "dominionViewController.h"


@implementation Thief

@synthesize thePlayer, revealedCards, trashedCard, helper;

- (NSString *) description {
	return @"Each other player reveals the top 2 cards of his deck. If they revealed any Treasure cards, they trash one of them that you choose. You may gain any or all of these trashed cards. They discard the other revealed cards.";
}

- (CardType) cardType {
	return ActionAttack;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {	
	[self.delegate actionFinished]; // nothing to do on the action phase
	return YES;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
	self.thePlayer = player;
	self.revealedCards = [player revealCardsFromDeck:2];
	NSMutableArray *cardsToCheck = [NSMutableArray arrayWithArray:revealedCards];
	Deck *treasureCards = [[Deck alloc] init];
	
	// are any of them treasure cards?
	for (NSUInteger i=0; i<[cardsToCheck count]; i++) {
		Card *card = [cardsToCheck objectAtIndex:i];
		[player.game setInfoLabel:[NSString stringWithFormat:@"%@ revealed %@.", player.name, card.name]];
		if (card.isTreasure) {
			[cardsToCheck removeObjectAtIndex:i];
			[treasureCards addCard:card];
			i--; // since we're removing the card at this index, we need to check this index again in the next loop iteration
		}
	}
	// if any were treasures, present them to current player to decide which one to trash
	if (treasureCards.numCardsLeft > 0) {
		HandViewHelper *theHelper = [[HandViewHelper alloc] initWithDeck:treasureCards AndController:player.game.controller];
		self.helper = theHelper;
		[theHelper release];
		self.helper.delegate = self;
		[self.helper displayHandWithMessage:@"Choose a card to trash."];
	} else {
		// guess we're done.
		if ([self.revealedCards count] > 0) {
			// move the revealed cards to discard
			for (Card *card in self.revealedCards) {
				[player.discardDeck addCard:card];
			}
		}
		self.thePlayer = nil;
		self.revealedCards = nil;
		self.trashedCard = nil;
		self.helper = nil;
		[self.delegate attackFinishedOnPlayer];
	}
	[treasureCards release];
}

# pragma mark -
# pragma mark HandViewHelperDelegate implementation 

- (void) cardSelected:(Card *)card {
	[self.helper hideEverything];
	self.helper = nil;
	self.trashedCard = card;
	// ask player if they want to gain this card
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.thePlayer.name message:[NSString stringWithFormat:@"Do you want to gain %@?", card.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];
}

# pragma mark -
# pragma mark UIAlertViewDelegate implementation

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	// buttonIndex == 0 means don't gain card
	if (buttonIndex == 0) {
		// okay, just trash it.
		[self.thePlayer.game.trashDeck addCard:self.trashedCard];
	} else {
		// gain it
		[self.thePlayer.game.currentPlayer.discardDeck addCard:self.trashedCard];
	}
	// now discard the other revealed card(s) regardless of attacker's choice
	Boolean foundOne = NO; // in case both revealed cards are the same treasure card. if this happens we've already discarded one.
	for (Card *card in self.revealedCards) {
		if (card == self.trashedCard && !foundOne) { // only skip if the current card is the same as the trashed card AND we haven't found it yet
			foundOne = YES;
			continue;
		}
		// discard
		[self.thePlayer.discardDeck addCard:card];
	}
	// attack's over
	self.thePlayer = nil;
	self.revealedCards = nil;
	self.trashedCard = nil;
	self.helper = nil;
	[self.delegate attackFinishedOnPlayer];
}

@end
