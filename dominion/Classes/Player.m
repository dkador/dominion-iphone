//
//  Player.m
//  dominion
//
//  Created by Daniel Kador on 12/20/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Player.h"
#import "Deck.h"
#import "Card.h"
#import "dominionViewController.h"


@implementation Player

@synthesize name, hand, drawDeck, cleanupDeck, discardDeck;
@synthesize currentState, actionCount, buyCount, coinCount;
@synthesize game, gameDelegate, actionDelegate;
@synthesize revealedHandButtons;

- (id) init {
	if ((self = [super init])) {
		Deck *deck = [[Deck alloc] init];
		deck.faceUp = NO;
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
		self.hand = deck;
		[deck release];		
		self.hand.name = @"Hand";
		
		self.revealedHandButtons = [NSMutableArray array];
	}
	return self;
}

- (NSMutableArray *) revealCardsFromDeck: (NSUInteger) numCards {
	NSMutableArray *cards = [NSMutableArray arrayWithCapacity:numCards];
	NSUInteger toReveal = numCards;
	// reveal until we've reached the correct # of cards, or we need to shuffle discard into the draw deck
	while (toReveal > 0 && self.drawDeck.numCardsLeft > 0) {
		Card *card = [self.drawDeck draw];
		[cards addObject:card];
		toReveal--;
	}
	if (toReveal > 0) {
		[self shuffleDiscardDeckIntoDrawDeck];
	}
	while (toReveal > 0 && self.drawDeck.numCardsLeft > 0) {
		Card *card = [self.drawDeck draw];
		[cards addObject:card];
	}
	return cards;
}

- (void) shuffleDiscardDeckIntoDrawDeck {
	Card *card;
	while (card = [self.discardDeck draw]) {
		[self.drawDeck addCard:card];
	}
	[self.drawDeck shuffle];
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
		[self shuffleDiscardDeckIntoDrawDeck];
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

- (void) promptForReactionCard {	
	[self revealHand];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.name message:@"Reveal a reaction card?" delegate:self cancelButtonTitle:@"No." otherButtonTitles:nil];
	for (NSUInteger i=0; i<self.hand.numCardsLeft; i++) {
		Card *card = [self.hand cardAtIndex:i];
		if (card.isReaction) {
			[alert addButtonWithTitle:card.name];
		}
	}
	[alert show];
	[alert release];
}

- (void) revealHand {
	CGFloat startingX = 0;
	CGFloat startingY = 0;
	CGFloat width = 204;
	CGFloat height = 163 * 2;	
	
	for (NSUInteger i=0; i<self.hand.numCardsLeft; i++) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button setBackgroundImage: [UIImage imageNamed:[self.hand cardAtIndex:i].imageFileName] forState:UIControlStateNormal];
		
		// make it do something when tapped
		//[button addTarget:self action:@selector(handButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
		//[button addTarget:self action:@selector(handButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
		//button.tag = i;
		
		// position the button in the view correctly
		button.frame = CGRectMake(startingX, startingY + (i * 40), width, height);
		[self.game.controller.view addSubview:button];
		[self.revealedHandButtons addObject:button];
	}	
}

- (void) hideHand {
	// remove revealed hand from screen
	for (UIButton *button in self.revealedHandButtons) {
		[button removeFromSuperview];
	}
	[self.revealedHandButtons removeAllObjects];
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self hideHand];
	if (buttonIndex == 0) {
		// tell the game there's nothing to reveal.
		[self.actionDelegate attackPlayerWithRevealedCard:nil];
	} else {
		// tell the game which card was revealed
		[self.actionDelegate attackPlayerWithRevealedCard:[alertView buttonTitleAtIndex:buttonIndex]];
	}
}

- (void) dealloc {
	self.name = nil;
	self.hand = nil;
	self.drawDeck = nil;
	self.cleanupDeck = nil;
	self.discardDeck = nil;
	self.game = nil;
	self.gameDelegate = nil;
	self.actionDelegate = nil;
	self.revealedHandButtons = nil;	[super dealloc];
}

@end
