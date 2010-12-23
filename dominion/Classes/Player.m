//
//  Player.m
//  dominion
//
//  Created by Daniel Kador on 12/20/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Player.h"
#import "Deck.h"


@implementation Player

@synthesize name, hand, drawDeck, cleanupDeck, discardDeck, trashDeck;
@synthesize currentState, actionCount, buyCount, coinCount;
@synthesize game, gameDelegate;

- (id) init {
	if ((self = [super init])) {
		Deck *deck = [[Deck alloc] init];
		self.drawDeck = deck;
		[deck release];
		self.drawDeck.name = @"Draw";
		
		deck = [[Deck alloc] init];
		self.cleanupDeck = deck;
		[deck release];
		self.cleanupDeck.name = @"Cleanup";
		
		deck = [[Deck alloc] init];
		self.discardDeck = deck;
		[deck release];
		self.discardDeck.name = @"Discard";
		
		deck = [[Deck alloc] init];
		self.trashDeck = deck;
		[deck release];
		self.trashDeck.name = @"Trash";
		
		deck = [[Deck alloc] init];
		self.hand = deck;
		[deck release];		
		self.hand.name = @"Hand";
	}
	return self;
}

- (void) drawNewHandFromDeck {
	[self drawFromDeck:10];
}

- (void) drawFromDeck: (NSUInteger) numCards {
	// draw until we've reached the correct # of cards to draw, or we need to shuffle discard into the draw deck
	NSUInteger toDraw = numCards;
	while (toDraw > 0 && self.drawDeck.numCardsLeft > 0) {
		[self drawSingleCardFromDeck];
		toDraw--;
	}
	if (toDraw > 0) {
		// shuffle in the discard deck
		Card *card;
		while (card = [self.discardDeck draw]) {
			[self.drawDeck addCard:card];
		}
		[self.drawDeck shuffle];
	}
	while (toDraw > 0 && [self drawSingleCardFromDeck]) {
		toDraw--;
	}
	[self.hand sort];
	[self.game setButtonText];
}

- (Boolean) drawSingleCardFromDeck {
	Card *card = [self.drawDeck draw];
	if (card) {
		if (card.cardType == Treasure) {
			self.coinCount += [card coins];
		}
		[self.hand addCard:card];
		[self.gameDelegate cardGained:card];
		return YES;
	} else {
		[self.gameDelegate couldNotDrawForPlayer:self];
		return NO;
	}
}

- (Card *) removeSingleCardFromHandAtIndex: (NSUInteger) index {
	Card *card = [self.hand removeCardAtIndex:index];
	[self cardRemovedFromHand: card];
	return card;
}

- (void) removeSingleCardFromHand: (Card *) card {
	[self.hand removeCard:card];
	[self cardRemovedFromHand: card];
}

- (void) cardRemovedFromHand: (Card *) card {
	if (card.cardType == Treasure) {
		self.coinCount -= card.coins;
	}
}

- (Boolean) checkIfPlayAvailableForCurrentTurn {
	Boolean playAvailable = YES;
	if (self.currentState == ActionState) {
		if (self.actionCount == 0) {
			playAvailable = NO;
		}
	} else if (self.currentState == BuyState) {
		if (self.buyCount == 0) {
			playAvailable = NO;
		}
	} else {
		// nothing to do on cleanup
		playAvailable = NO;
	}
	if (playAvailable == NO) {
		// move turn state
		[self.game doneWithCurrentTurnState];
	}
	return playAvailable;
}

- (void) dealloc {
	[self.name release];
	[self.hand release];
	[self.drawDeck release];
	[self.cleanupDeck release];
	[self.discardDeck release];
	[self.trashDeck release];
	[self.game release];
	self.gameDelegate = nil;
	[super dealloc];
}

@end
