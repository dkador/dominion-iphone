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
#import "Player.h"
#import "ActionCard.h"


@interface Game (internal)

+ (void) setTextForButton: (UIButton *) button WithDeck: (Deck *) deck;
+ (void) setTextForButton: (UIButton *) button WithCard: (Card *) card;

- (void) setInfoLabel: (NSString *) text;

@end

@implementation Game (internal)

+ (void) setTextForButton: (UIButton *) button WithDeck: (Deck *) deck {
	if (deck.faceUp) {
		Card *card = [deck peek];
		[button setBackgroundImage: [UIImage imageNamed:card.imageFileName] forState:UIControlStateNormal];
		[button setTitle:[NSString stringWithFormat:@"%d Left", deck.numCardsLeft] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		button.titleLabel.backgroundColor = [UIColor whiteColor];
		//[button setTitle:[NSString stringWithFormat:@"%@\nCost: %d\n# Left: %d", card.name, card.cost, deck.numCardsLeft] forState:UIControlStateNormal];
	} else {
		[button setBackgroundImage: [UIImage imageNamed:@"back.jpg"] forState:UIControlStateNormal];
		[button setTitle:[NSString stringWithFormat:@"%d Left", deck.numCardsLeft] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
		button.titleLabel.backgroundColor = [UIColor whiteColor];
		//[button setTitle:[NSString stringWithFormat:@"%@\n# Left: %d", deck.name, deck.numCardsLeft] forState:UIControlStateNormal];
	}
}

+ (void) setTextForButton: (UIButton *) button WithCard: (Card *) card {
	[button setImage:[UIImage imageNamed:card.imageFileName] forState:UIControlStateNormal];
//	[button setTitle:[NSString stringWithFormat:@"%@\n%@\nCost : %d", card.name, card.description, card.cost] forState:UIControlStateNormal];
}

- (void) setInfoLabel: (NSString *) text {
	Player *player = self.currentPlayer;
	NSString *newText = [NSString stringWithFormat:@"Player: %@, Actions: %d, Buys: %d, Coins: %d", player.name, player.actionCount, player.buyCount, player.coinCount];
	self.controller.textView.text = newText;
	if (text) {
		if ([text isEqualToString:@""]) {
			self.controller.textDetails.text = text;
		} else {
			self.controller.textDetails.text = [NSString stringWithFormat:@"%@\n%@", text, self.controller.textDetails.text];
		}

	}
}

@end

@implementation Game

@synthesize controller;
@synthesize kingdomDecks;
@synthesize estateDeck, duchyDeck, provinceDeck, curseDeck;
@synthesize copperDeck, silverDeck, goldDeck, trashDeck;
@synthesize players, currentPlayerIndex;
@synthesize isDiscarding, numCardsDiscarded, numCardsToDiscard;
@synthesize isTrashing, numCardsTrashed, maxCardsToTrash;
@synthesize isGainingCard, gainingCardMaxCost;
@synthesize needsToChooseActionCard;
@synthesize currentPlayerIndexToAttack, currentAttackCard;

- (Player *) currentPlayer {
	return [self.players objectAtIndex:self.currentPlayerIndex];
}

- (id) initWithController: (dominionViewController *) theController	{
	self = [super init];
	if (self) {
		self.controller = theController;
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
	
	[Game setTextForButton:self.controller.deckButton WithDeck:self.currentPlayer.drawDeck];
	[Game setTextForButton:self.controller.discardButton WithDeck:self.currentPlayer.discardDeck];
	[Game setTextForButton:self.controller.trashButton WithDeck:self.trashDeck];
	
	[self.controller setupHandButtons:[self.currentPlayer.hand.cards count]];
	NSInteger count = 0;
	for (Card *card in self.currentPlayer.hand.cards) {
		[Game setTextForButton:[self.controller.handButtons objectAtIndex:count] WithCard:card];
		count++;
	}
	
	self.controller.actionButton.backgroundColor = nil;
	self.controller.buyButton.backgroundColor = nil;
	self.controller.cleanupButton.backgroundColor = nil;
	if (self.currentPlayer.currentState == ActionState) {
		self.controller.actionButton.backgroundColor = [UIColor grayColor];
	} else if (self.currentPlayer.currentState == BuyState) {
		self.controller.buyButton.backgroundColor = [UIColor grayColor];
	} else {
		self.controller.cleanupButton.backgroundColor = [UIColor grayColor];
	}
	[self setInfoLabel:nil];
}

- (void) setupGame {
	// setup decks
	Deck *deck;
	
	self.kingdomDecks = [[KingdomCards sharedInstance] generateKingdomDecks];
	
	deck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] estate] AndNumber:24];
	self.estateDeck = deck;
	[deck release];
	deck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] duchy] AndNumber:12];
	self.duchyDeck = deck;
	[deck release];
	deck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] province] AndNumber:10];
	self.provinceDeck = deck;
	[deck release];
	deck = [[HomogenousDeck alloc] initWithCard:[[VictoryCards sharedInstance] curse] AndNumber:30];
	self.curseDeck = deck;
	[deck release];
	deck = [[HomogenousDeck alloc] initWithCard:[[TreasureCards sharedInstance] copper] AndNumber:60];
	self.copperDeck = deck;
	[deck release];
	deck = [[HomogenousDeck alloc] initWithCard:[[TreasureCards sharedInstance] silver] AndNumber:40];
	self.silverDeck = deck;
	[deck release];
	deck = [[HomogenousDeck alloc] initWithCard:[[TreasureCards sharedInstance] gold] AndNumber:30];
	self.goldDeck = deck;
	[deck release];
	deck = [[Deck alloc] init];
	self.trashDeck = deck;
	[deck release];
	self.trashDeck.name = @"Trash";
	
	// setup players
	NSMutableArray *temp = [NSMutableArray arrayWithCapacity:2];
	for (NSUInteger i=1; i<=2; i++) {
		Player *player = [[Player alloc] init];
		player.name = [NSString stringWithFormat:@"%d", i];
		player.currentState = ActionState;
		player.actionCount = 1;
		player.buyCount = 50;
		player.coinCount = 5000;
		player.game = self;
		
		for (NSInteger i=0; i<7; i++) {
			[player.drawDeck addCard:[self.copperDeck draw]];
		}
		for (NSInteger i=0; i<3; i++) {
			[player.drawDeck addCard:[self.estateDeck draw]];
		}
		[player.drawDeck shuffle];
		[player drawNewHandFromDeck];
		 
		[temp addObject:player];
		[player release];
	}
	
	self.players = [NSArray arrayWithArray:temp];
		
	[self setButtonText];
	[self setInfoLabel:@""];
}

- (void) cleanUpGame {
	// remove references to game from players
	for (Player *player in self.players) {
		player.game = nil;
	}
}

- (Boolean) checkIfPlayAvailableForCurrentTurn {
	Boolean playAvailable = YES;
	if (self.currentPlayer.currentState == ActionState) {
		if (self.currentPlayer.actionCount == 0) {
			playAvailable = NO;
		}
	} else if (self.currentPlayer.currentState == BuyState) {
		if (self.currentPlayer.buyCount == 0) {
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
	if (self.currentPlayer.currentState == ActionState || self.currentPlayer.currentState == BuyState) {
		if (self.isDiscarding) {
			// they're done discarding, move on
			NSInteger temp = self.numCardsDiscarded;
			self.isDiscarding = NO;
			self.numCardsDiscarded = 0;
			self.numCardsToDiscard = 0;
			[self.currentPlayer.gameDelegate discardFinished:temp ForPlayer:self.currentPlayer];
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
			self.currentPlayer.currentState++;
			if (self.currentPlayer.currentState == BuyState) {
				[self setInfoLabel:@"Buy phase."];
			} else if (self.currentPlayer.currentState == CleanupState) {
				[self setInfoLabel:@"Cleanup phase."];
			}
			[self setButtonText];
		}
	} else {
		// reset everything for next turn
		self.currentPlayer.currentState = ActionState;
		self.currentPlayer.actionCount = 1;
		self.currentPlayer.buyCount = 50;
		self.currentPlayer.coinCount = 5000;
		self.numCardsDiscarded = 0;
		self.numCardsToDiscard = 0;
		self.isTrashing = NO;
		self.numCardsTrashed = 0;
		self.maxCardsToTrash = 0;
		self.isGainingCard = NO;
		self.gainingCardMaxCost = 0;
		self.needsToChooseActionCard = NO;
		self.currentPlayer.gameDelegate = nil;
		// move all cards out of hand into cleanup deck
		Card *card;
		while (card = [self.currentPlayer.hand draw]) {
			[self.currentPlayer.cleanupDeck addCard:card];
		}
		// move all cards out of cleanup deck into discard deck
		while (card = [self.currentPlayer.cleanupDeck draw]) {
			[self.currentPlayer.discardDeck addCard:card];
		}
		if (![self isGameOver]) {
			// draw 5 new cards
			[self.currentPlayer drawNewHandFromDeck];
			self.currentPlayerIndex++;
			if (self.currentPlayerIndex == [self.players count]) {
				self.currentPlayerIndex = 0;
			}
			[self setButtonText];
			[self setInfoLabel:@""];
			[self setInfoLabel:@"Action phase."];
		}
	}
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
		// move all cards into decks for all players
		NSString *gameOverString = @"GAME OVER! ";
		for (Player *player in self.players) {
			Card *card;
			while ((card = [player.hand draw])) {
				[player.drawDeck addCard:card];
			}
			while ((card = [player.cleanupDeck draw])) {
				[player.drawDeck addCard:card];
			}
			while ((card = [player.discardDeck draw])) {
				[player.drawDeck addCard:card];
			}
			
			// count up victory points
			NSInteger victoryPoints = 0;
			for (int i=0; i<player.drawDeck.numCardsLeft; i++) {
				victoryPoints += [[player.drawDeck cardAtIndex:i] victoryPointsForPlayer:player];
			}
			gameOverString = [gameOverString stringByAppendingFormat:@"%@ got %d victory points! ", player.name, victoryPoints];
		}
		[self setInfoLabel:gameOverString];
	}
	return gameOver;
}


- (void) cardInHandSelectedAtIndex: (NSUInteger) index {
	if (self.currentPlayer.currentState == ActionState) {
		if (self.isDiscarding) {
			Card *card = [self.currentPlayer removeSingleCardFromHandAtIndex:index];
			[self.currentPlayer.cleanupDeck addCard:card];
			[self setButtonText];
			self.numCardsDiscarded++;
			self.numCardsToDiscard--;
			if (self.numCardsToDiscard == 0) {
				// they're done discarding, move on
				self.isDiscarding = NO;
				[self setInfoLabel:[NSString stringWithFormat:@"You discarded %d cards.", self.numCardsDiscarded]];
				[self.currentPlayer.gameDelegate discardFinished:self.numCardsDiscarded ForPlayer:self.currentPlayer];
				//self.gameDelegate = nil;
			}
			return;
		} else if (self.isTrashing) {
			Card *card = [self.currentPlayer.hand cardAtIndex:index];
			if ([self.currentPlayer.gameDelegate isTrashAllowed:card ForPlayer:self.currentPlayer]) {
				card = [self.currentPlayer removeSingleCardFromHandAtIndex:index];
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
					[self.currentPlayer.gameDelegate cardsTrashed:cards ForPlayer:self.currentPlayer];
					//self.gameDelegate = nil;
				}
			} else {
				[self setInfoLabel:@"Cannot trash that card.  Choose another."];
			}
		} else if (self.needsToChooseActionCard) {
			Card *card = [self.currentPlayer.hand cardAtIndex:index];
			if (card.cardType != Action) {
				return;
			}
			self.needsToChooseActionCard = NO;
			[self.currentPlayer.hand removeCardAtIndex:index];
			[self.currentPlayer.cleanupDeck addCard:card];
			[self setButtonText];
			[self setInfoLabel:[NSString stringWithFormat:@"You selected %@.", card.name]];
			[self.currentPlayer.gameDelegate actionCardSelected:card ForPlayer:self.currentPlayer];
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
	} else if (cardType == ProvinceType) {
		deck = self.provinceDeck;
	} else {
		deck = self.curseDeck;
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
	return card != nil && self.isGainingCard && self.gainingCardMaxCost >= card.cost && [self.currentPlayer.gameDelegate isGainAllowed:card ForPlayer:self.currentPlayer];
}

- (Boolean) canBuyCard: (Card *) card {
	if (self.currentPlayer.currentState != BuyState) {
		return NO;
	}
	if (self.currentPlayer.buyCount == 0) {
		return NO;
	}
	if (card.cost <= self.currentPlayer.coinCount) {
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
		self.currentPlayer.coinCount -= [deck peek].cost;
		self.currentPlayer.buyCount--;
		[self gainCardFromDeck:deck];
		return YES;
	}
	return NO;
}

- (Card *) gainCardFromDeck: (Deck *) deck {
	Card *card = [deck draw];
	if (card) {
		[self.currentPlayer.cleanupDeck addCard:card];
		[self setButtonText];
	}
	return card;
}

- (Boolean) canPlayCardInHandAtIndex: (NSUInteger) index {
	if (self.currentPlayer.currentState != ActionState) {
		return NO;
	}
	if (self.currentPlayer.actionCount == 0) {
		return NO;
	}
	return YES;
}

- (void) playCardInHandAtIndex: (NSUInteger) index {
	if (![self canPlayCardInHandAtIndex:index]) {
		return;
	}
	Card *card = [self.currentPlayer.hand cardAtIndex:index];
	if (![card isKindOfClass:[ActionCard class]]) {
		return;
	}
	ActionCard *actionCard = (ActionCard *) card;
	actionCard.delegate = self;
	self.currentPlayer.gameDelegate = actionCard;
	self.currentAttackCard = actionCard;
	[self.currentPlayer.hand removeCardAtIndex:index];
	[self.currentPlayer.cleanupDeck addCard:actionCard];
	self.currentPlayer.actionCount--;
	[self setButtonText];
	[actionCard takeAction:self.currentPlayer];
}

- (void) dealloc {
	self.kingdomDecks = nil;
	self.estateDeck = nil;
	self.duchyDeck = nil;
	self.provinceDeck = nil;
	self.curseDeck = nil;
	self.copperDeck = nil;
	self.silverDeck = nil;
	self.goldDeck = nil;
	self.trashDeck = nil;
	self.players = nil;
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
	[self setButtonText];
	//[self setInfoLabel:@""]; TODO
	
	if (self.currentAttackCard.isAttack) {
		// loop through all players, starting with player after current player, going up to player before current player
		self.currentPlayerIndexToAttack = self.currentPlayerIndexToAttack + 1;
		if (self.currentPlayerIndexToAttack == [self.players count]) {
			self.currentPlayerIndexToAttack = 0; // wrap around if the current player is the last player
		}
		if (self.currentPlayerIndexToAttack != self.currentPlayerIndex) {
			// see if player has a reaction card so attack ignores them
			[[self.players objectAtIndex:self.currentPlayerIndexToAttack] promptForReactionCard];
		}
	} else {
		[self attackFinished];
	}

}

- (void) attackPlayerWithRevealedCard: (NSString *) name {
	if (name) {
		// a card was revealed, so show it
		[self setInfoLabel:[NSString stringWithFormat:@"%@ revealed by %@.", name, [[self.players objectAtIndex:self.currentPlayerIndexToAttack] name]]];
		[self attackFinishedOnPlayer];
	} else {
		// no card was revealed.  ATTACK!
		[self.currentAttackCard attackPlayer:[self.players objectAtIndex:self.currentPlayerIndexToAttack]];
	}
}

- (void) attackFinishedOnPlayer {
	// move on to next player
	self.currentPlayerIndexToAttack++;
	if (self.currentPlayerIndexToAttack == [self.players count]) {
		self.currentPlayerIndexToAttack = 0; // wrap around if the current player is the last player
	}
	// is there more to do (i.e. are we not back to current player)?
	if (self.currentPlayerIndexToAttack != self.currentPlayerIndex) {
		Player *attackee = [self.players objectAtIndex:self.currentPlayerIndexToAttack];
		[attackee promptForReactionCard];
	} else {
		// okay, attack is finished, hooray!
		[self attackFinished];
	}
}

- (void) attackFinished {
	self.currentAttackCard = nil;
	[self setButtonText];
	[self setInfoLabel:[NSString stringWithFormat:@"%@ played.", [self.currentPlayer.gameDelegate name]]];
	self.currentPlayer.gameDelegate = nil;
}

@end
