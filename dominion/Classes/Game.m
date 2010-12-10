//
//  Game.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Game.h"
#import "dominionViewController.h"
#import "HomogenousDeck.h"


@interface Game (internal)

+ (void) setTextForButton: (UIButton *) button WithDeck: (Deck *) deck;
+ (void) setTextForButton: (UIButton *) button WithCard: (Card *) card;

- (void) setInfoLabel: (NSString *) text;

@end

@implementation Game (internal)

+ (void) setTextForButton: (UIButton *) button WithDeck: (Deck *) deck {
	if ([deck isKindOfClass:[HomogenousDeck class]] == YES) {
		Card *card = [deck peek];
		[button setTitle:[NSString stringWithFormat:@"%@\nCost: %d\n# Left: %d", card.name, card.cost, deck.numCardsLeft] forState:UIControlStateNormal];
	} else {
		[button setTitle:[NSString stringWithFormat:@"%@\n# Left: %d", deck.name, deck.numCardsLeft] forState:UIControlStateNormal];
	}
}

+ (void) setTextForButton: (UIButton *) button WithCard: (Card *) card {
	[button setTitle:[NSString stringWithFormat:@"%@\n%@\nCost : %d", card.name, card.description, card.cost] forState:UIControlStateNormal];
}

- (void) setInfoLabel: (NSString *) text {
	NSString *newText = [NSString stringWithFormat:@"Actions: %d, Buys: %d, Coins: %d", self.actionCount, self.buyCount, self.coinCount];
	self.controller.textView.text = newText;
	if (text) {
		self.controller.textDetails.text = text;
	}
}

@end

@implementation Game

@synthesize controller, handButtons;
@synthesize kingdomDecks;
@synthesize estateDeck, duchyDeck, provinceDeck, curseDeck;
@synthesize copperDeck, silverDeck, goldDeck;
@synthesize drawDeck, cleanupDeck, discardDeck, trashDeck;
@synthesize hand, actionCount, buyCount, coinCount;
@synthesize currentState;
@synthesize isDiscarding, numCardsDiscarded, numCardsToDiscard, gameDelegate;
@synthesize isTrashing, numCardsTrashed, maxCardsToTrash;
@synthesize isGainingCard, gainingCardMaxCost;
@synthesize needsToChooseActionCard;

- (id) initWithController: (dominionViewController *) theController	{
	self = [super init];
	if (self) {
		self.controller = theController;
		self.handButtons = [NSMutableArray arrayWithObjects:theController.hand1Button,
							theController.hand2Button,
							theController.hand3Button,
							theController.hand4Button,
							theController.hand5Button,
							theController.hand6Button,
							theController.hand7Button,
							theController.hand8Button,
							theController.hand9Button,
							theController.hand10Button,
							nil];
	}
	return self;
}

- (void) setButtonText {
	[Game setTextForButton:self.controller.kingdom1Button WithDeck:[self.kingdomDecks objectAtIndex:0]];
	[Game setTextForButton:self.controller.kingdom2Button WithDeck:[self.kingdomDecks objectAtIndex:1]];
	[Game setTextForButton:self.controller.kingdom3Button WithDeck:[self.kingdomDecks objectAtIndex:2]];
	[Game setTextForButton:self.controller.kingdom4Button WithDeck:[self.kingdomDecks objectAtIndex:3]];
	[Game setTextForButton:self.controller.kingdom5Button WithDeck:[self.kingdomDecks objectAtIndex:4]];
	[Game setTextForButton:self.controller.kingdom6Button WithDeck:[self.kingdomDecks objectAtIndex:5]];
	[Game setTextForButton:self.controller.kingdom7Button WithDeck:[self.kingdomDecks objectAtIndex:6]];
	[Game setTextForButton:self.controller.kingdom8Button WithDeck:[self.kingdomDecks objectAtIndex:7]];
	[Game setTextForButton:self.controller.kingdom9Button WithDeck:[self.kingdomDecks objectAtIndex:8]];
	[Game setTextForButton:self.controller.kingdom10Button WithDeck:[self.kingdomDecks objectAtIndex:9]];
	
	[Game setTextForButton:self.controller.estateButton WithDeck:self.estateDeck];
	[Game setTextForButton:self.controller.duchyButton WithDeck:self.duchyDeck];
	[Game setTextForButton:self.controller.provinceButton WithDeck:self.provinceDeck];
	[Game setTextForButton:self.controller.curseButton WithDeck:self.curseDeck];
	
	[Game setTextForButton:self.controller.copperButton WithDeck:self.copperDeck];
	[Game setTextForButton:self.controller.silverButton WithDeck:self.silverDeck];
	[Game setTextForButton:self.controller.goldButton WithDeck:self.goldDeck];
	
	[Game setTextForButton:self.controller.deckButton WithDeck:self.drawDeck];
	[Game setTextForButton:self.controller.discardButton WithDeck:self.discardDeck];
	[Game setTextForButton:self.controller.trashButton WithDeck:self.trashDeck];
	
	NSInteger count = 0;
	for (Card *card in self.hand.cards) {
		[Game setTextForButton:[self.handButtons objectAtIndex:count] WithCard:card];
		count++;
	}
	for (NSInteger i=count; i<10; i++) {
		[[self.handButtons objectAtIndex:i] setTitle:@"" forState:UIControlStateNormal];
	}
	
	self.controller.actionButton.backgroundColor = nil;
	self.controller.buyButton.backgroundColor = nil;
	self.controller.cleanupButton.backgroundColor = nil;
	if (self.currentState == ActionState) {
		self.controller.actionButton.backgroundColor = [UIColor grayColor];
	} else if (self.currentState == BuyState) {
		self.controller.buyButton.backgroundColor = [UIColor grayColor];
	} else {
		self.controller.cleanupButton.backgroundColor = [UIColor grayColor];
	}
	[self setInfoLabel:nil];
}

- (void) setupGame {
	self.kingdomDecks = [[KingdomCards sharedInstance] generateKingdomDecks];
	self.estateDeck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] estate] AndNumber:24];
	self.duchyDeck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] duchy] AndNumber:12];
	self.provinceDeck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] province] AndNumber:1];
	self.curseDeck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] curse] AndNumber:30];
	self.copperDeck = [[HomogenousDeck alloc] initWithCard:[[TreasureCards sharedInstance] copper] AndNumber:60];
	self.silverDeck = [[HomogenousDeck alloc] initWithCard:[[TreasureCards sharedInstance] silver] AndNumber:40];
	self.goldDeck = [[HomogenousDeck alloc] initWithCard:[[TreasureCards sharedInstance] gold] AndNumber:30];
	
	Deck *deck = [[Deck alloc] init];
	self.drawDeck = deck;
	[deck release];
	self.drawDeck.name = @"Draw";
	
	deck = [[Deck alloc] init];
	self.cleanupDeck = [[Deck alloc] init];
	[deck release];
	self.cleanupDeck.name = @"Cleanup";
	
	deck = [[Deck alloc] init];
	self.discardDeck = [[Deck alloc] init];
	[deck release];
	self.discardDeck.name = @"Discard";
	
	deck = [[Deck alloc] init];
	self.trashDeck = [[Deck alloc] init];
	[deck release];
	self.trashDeck.name = @"Trash";
	
	deck = [[Deck alloc] init];
	self.hand = deck;
	[deck release];
	
	for (NSInteger i=0; i<7; i++) {
		[self.drawDeck addCard:[[TreasureCards sharedInstance] copper]];
	}
	for (NSInteger i=0; i<3; i++) {
		[self.drawDeck addCard:[[VictoryCards sharedInstance] estate]];
	}
	
	self.currentState = ActionState;
	self.actionCount = 1;
	self.buyCount = 1;
	self.coinCount = 0;
	
	[self.drawDeck shuffle];
	[self drawNewHandFromDeck];
	
	while ([self checkIfPlayAvailableForCurrentTurn] == NO) {
		// do nothing, just continue until the player can do something
	}
		
	[self setButtonText];
	[self setInfoLabel:@""];
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
		[self doneWithCurrentTurnState];
	}
	return playAvailable;
}

- (void) doneWithCurrentTurnState {
	if (self.currentState == ActionState || self.currentState == BuyState) {
		if (self.isDiscarding) {
			// they're done discarding, move on
			NSInteger temp = self.numCardsDiscarded;
			self.isDiscarding = NO;
			self.numCardsDiscarded = 0;
			self.numCardsToDiscard = 0;
			[self.gameDelegate discardFinished:temp InGame:self];			
			//self.gameDelegate = nil;
		} else if (self.isTrashing) {
			self.isTrashing = NO;
			self.numCardsTrashed = 0;
			self.maxCardsToTrash = 0;
		} else if (self.isGainingCard) {
			self.isGainingCard = NO;
			self.gainingCardMaxCost = 0;
		} else if (self.needsToChooseActionCard) {
			self.needsToChooseActionCard = NO;
		} else {
			self.currentState++;
			if (self.currentState == BuyState) {
				[self setInfoLabel:@"Buy phase."];
			} else if (self.currentState == CleanupState) {
				[self setInfoLabel:@"Cleanup phase."];
			}
			[self setButtonText];
		}
	} else {
		// reset everything for next turn
		self.currentState = ActionState;
		self.actionCount = 1;
		self.buyCount = 50;
		self.coinCount = 5000;
		self.numCardsDiscarded = 0;
		self.numCardsToDiscard = 0;
		self.isTrashing = NO;
		self.numCardsTrashed = 0;
		self.maxCardsToTrash = 0;
		self.isGainingCard = NO;
		self.gainingCardMaxCost = 0;
		self.needsToChooseActionCard = NO;
		self.gameDelegate = nil;
		// move all cards out of hand into cleanup deck
		Card *card;
		while (card = [self.hand draw]) {
			[self.cleanupDeck addCard:card];
		}
		// move all cards out of cleanup deck into discard deck
		while (card = [self.cleanupDeck draw]) {
			[self.discardDeck addCard:card];
		}
		if (![self isGameOver]) {
			// draw 5 new cards
			[self drawNewHandFromDeck];
			[self setButtonText];
			[self setInfoLabel:@"Action phase."];
		}
	}
	//[self checkIfPlayAvailableForCurrentTurn];
}

- (Boolean) isGameOver {
	Boolean gameOver = NO;
	// first check if the province deck is empty
	if (self.provinceDeck.numCardsLeft == 0) {
		gameOver = YES;
	}
	// now see if there are three supply decks that are empty
	if (!gameOver) {
		NSInteger count = 0;
		for (Deck *deck in self.kingdomDecks) {
			if (deck.numCardsLeft == 0) {
				count++;
			}
		}
		NSArray *array = [NSArray arrayWithObjects:self.copperDeck, self.silverDeck, self.goldDeck,
						  self.estateDeck, self.duchyDeck, self.curseDeck, nil];
		for (Deck *deck in array) {
			if (deck.numCardsLeft == 0) {
				count++;
			}
		}
		if (count >= 3) {
			gameOver = YES;
		}
	}
	
	if (gameOver) {
		// move all cards into deck
		Card *card;
		while ((card = [self.hand draw])) {
			[self.drawDeck addCard:card];
		}
		while ((card = [self.cleanupDeck draw])) {
			[self.drawDeck addCard:card];
		}
		while ((card = [self.discardDeck draw])) {
			[self.drawDeck addCard:card];
		}
		
		// count up victory points
		NSInteger victoryPoints = 0;
		for (int i=0; i<self.drawDeck.numCardsLeft; i++) {
			victoryPoints += [[self.drawDeck cardAtIndex:i] victoryPointsInGame:self];
		}
		[self setInfoLabel:[NSString stringWithFormat:@"GAME OVER! You got %d victory points!", victoryPoints]];
	}
	return gameOver;
}

- (void) drawNewHandFromDeck {
	[self drawFromDeck:5];
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
	while (toDraw > 0 && self.drawDeck.numCardsLeft > 0) {
		[self drawSingleCardFromDeck];
		toDraw--;
	}
	[self.hand sort];
	[self setButtonText];
}

- (void) drawSingleCardFromDeck {
	Card *card = [self.drawDeck draw];
	if (card) {
		if (card.cardType == Treasure) {
			self.coinCount += [card coins];
		}
		[self.hand addCard:card];
		[self.gameDelegate cardGained:card];
	} else {
		[self.gameDelegate couldNotDrawInGame:self];
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

- (void) cardInHandSelectedAtIndex: (NSUInteger) index {
	if (self.currentState == ActionState) {
		if (self.isDiscarding) {
			Card *card = [self removeSingleCardFromHandAtIndex:index];
			[self.cleanupDeck addCard:card];
			[self setButtonText];
			self.numCardsDiscarded++;
			self.numCardsToDiscard--;
			if (self.numCardsToDiscard == 0) {
				// they're done discarding, move on
				self.isDiscarding = NO;
				[self setInfoLabel:[NSString stringWithFormat:@"You discarded %d cards.", self.numCardsDiscarded]];
				[self.gameDelegate discardFinished:self.numCardsDiscarded InGame:self];
				//self.gameDelegate = nil;
			}
			return;
		} else if (self.isTrashing) {
			Card *card = [self.hand cardAtIndex:index];
			if ([self.gameDelegate isTrashAllowed:card InGame:self]) {
				card = [self removeSingleCardFromHandAtIndex:index];
				[self.trashDeck addCard:card];
				[self setButtonText];
				self.numCardsTrashed++;
				if (self.numCardsTrashed == self.maxCardsToTrash) {
					self.isTrashing = NO;
					// peek at the trash pile to see what we just got rid of
					NSMutableArray *cards = [NSMutableArray arrayWithCapacity:self.maxCardsToTrash];
					for (int i=0; i<self.maxCardsToTrash; i++) {
						[cards addObject:[self.trashDeck cardAtIndex:self.trashDeck.numCardsLeft-1-i]];
					}
					[self setInfoLabel:[NSString stringWithFormat:@"You trashed %d cards.", self.numCardsTrashed]];
					[self.gameDelegate cardsTrashed:cards InGame:self];
					//self.gameDelegate = nil;
				}
			} else {
				[self setInfoLabel:@"Cannot trash that card.  Choose another."];
			}
		} else if (self.needsToChooseActionCard) {
			Card *card = [self.hand cardAtIndex:index];
			if (card.cardType != Action) {
				return;
			}
			self.needsToChooseActionCard = NO;
			[self.hand removeCardAtIndex:index];
			[self.cleanupDeck addCard:card];
			[self setButtonText];
			id delegateBefore = self.gameDelegate;
			[self setInfoLabel:[NSString stringWithFormat:@"You selected %@.", card.name]];
			[self.gameDelegate actionCardSelected:card InGame:self];
			if (delegateBefore == self.gameDelegate) {
				// throne room has to muck with the delegates, so don't reset the delegate sometimes
				//self.gameDelegate = nil;
			}
		} else {
			[self playCardInHandAtIndex:index];
		}
	} 
}

- (Boolean) buyKingdomCardAtIndex: (NSUInteger) index {
	HomogenousDeck *deck = [self.kingdomDecks objectAtIndex:index];
	return [self buyCardFromDeck:deck];
}

- (Boolean) buyVictoryCard: (VictoryCardTypes) cardType {
	Deck *deck;
	if (cardType == EstateType) {
		deck = self.estateDeck;
	} else if (cardType == DuchyType) {
		deck = self.duchyDeck;
	} else {
		deck = self.provinceDeck;
	}
	return [self buyCardFromDeck:deck];
}

- (Boolean) buyTreasureCard: (TreasureCardTypes) cardType {
	Deck *deck;
	if (cardType == CopperType) {
		deck = self.copperDeck;
	} else if (cardType == SilverType) {
		deck = self.silverDeck;
	} else {
		deck = self.goldDeck;
	}
	return [self buyCardFromDeck:deck];
}

- (Boolean) canGainCard: (Card *) card {
	return card != nil && self.isGainingCard && self.gainingCardMaxCost >= card.cost && [self.gameDelegate isGainAllowed:card InGame:self];
}

- (Boolean) canBuyCard: (Card *) card {
	if (self.currentState != BuyState) {
		return NO;
	}
	if (self.buyCount == 0) {
		return NO;
	}
	if (card.cost <= self.coinCount) {
		return YES;
	}
	return NO;
}

- (Boolean) buyCardFromDeck: (Deck *) deck {
	if (deck.numCardsLeft == 0) {
		return NO;
	}
	if ([self canGainCard:[deck peek]]) {
		Card *card = [self gainCardFromDeck:deck];
		self.isGainingCard = NO;
		self.gainingCardMaxCost = 0;
		[self setButtonText];
		[self setInfoLabel:[NSString stringWithFormat:@"You gained %@!", card.name]];
		return YES;		
	} else if ([self canBuyCard:[deck peek]]) {
		Card *card = [self gainCardFromDeck:deck];
		self.coinCount -= card.cost;
		self.buyCount--;
		return YES;
	}
	return NO;
}

- (Card *) gainCardFromDeck: (Deck *) deck {
	Card *card = [deck draw];
	if (card) {
		[self.cleanupDeck addCard:card];
		[self setButtonText];
	}
	return card;
}

- (Boolean) canPlayCardInHandAtIndex: (NSUInteger) index {
	if (self.currentState != ActionState) {
		return NO;
	}
	if (self.actionCount == 0) {
		return NO;
	}
	return YES;
}

- (void) playCardInHandAtIndex: (NSUInteger) index {
	if (![self canPlayCardInHandAtIndex:index]) {
		return;
	}
	Card *card = [self.hand cardAtIndex:index];
	if (![card isKindOfClass:[ActionCard class]]) {
		return;
	}
	ActionCard *actionCard = (ActionCard *) card;
	actionCard.delegate = self;
	self.gameDelegate = actionCard;
	[self.hand removeCardAtIndex:index];
	[self.cleanupDeck addCard:actionCard];
	self.actionCount--;
	[self setButtonText];
	[actionCard takeAction:self];
}

- (void) dealloc {
	[self.kingdomDecks release];
	[self.estateDeck release];
	[self.duchyDeck release];
	[self.provinceDeck release];
	[self.copperDeck release];
	[self.silverDeck release];
	[self.goldDeck release];
	[self.drawDeck release];
	[self.cleanupDeck release];
	[self.discardDeck release];
	[self.trashDeck release];
	[self.hand release];
	[super dealloc];
}

# pragma mark -
# pragma mark ActionDelegate Implementation

- (void) discardCards: (NSUInteger) numberOfCardsToDiscard {
	self.numCardsToDiscard = numberOfCardsToDiscard;
	self.isDiscarding = YES;
	if (numberOfCardsToDiscard > 0) {
		[self setInfoLabel:[NSString stringWithFormat:@"Please discard %d cards.", numberOfCardsToDiscard]];
	} else {
		[self setInfoLabel:@"Discard any number of cards. Press Next when finished."];
	}
}

- (void) trashCards: (NSUInteger) numberOfCardsToTrash WithMessage: (NSString *) message {
	self.maxCardsToTrash = numberOfCardsToTrash;
	self.isTrashing = YES;
	[self setInfoLabel:message];
}

- (void) gainCardCostingUpTo: (NSUInteger) maxCost {
	self.isGainingCard = YES;
	self.gainingCardMaxCost = maxCost;
	[self setInfoLabel:[NSString stringWithFormat:@"Gain a card costing up to %d.", maxCost]];
}

- (void) chooseActionCard {
	self.needsToChooseActionCard = YES;
	[self setInfoLabel:@"Choose an action card."];
}

- (void) actionFinished {
	self.gameDelegate = nil;
	[self setButtonText];
	[self setInfoLabel:@""];
}

@end
