//
//  Game.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "ActionDelegate.h"
#import "GameDelegate.h"
#import "Card.h"
#import "ActionCard.h"
#import "KingdomCards.h"
#import "VictoryCards.h"
#import "TreasureCards.h"

@class dominionViewController;

typedef enum {
	ActionState,
	BuyState,
	CleanupState
} TurnState;

@interface Game : NSObject <ActionDelegate> {
	dominionViewController *controller;
	NSMutableArray *handButtons;
	
	NSMutableArray *kingdomDecks;
	Deck *estateDeck;
	Deck *duchyDeck;
	Deck *provinceDeck;
	Deck *curseDeck;
	Deck *copperDeck;
	Deck *silverDeck;
	Deck *goldDeck;	
	Deck *drawDeck;
	Deck *cleanupDeck;
	Deck *discardDeck;
	Deck *trashDeck;
	
	Deck *hand;
	NSUInteger actionCount;
	NSUInteger buyCount;
	NSUInteger coinCount;
	
	TurnState currentState;
	Boolean isDiscarding;
	NSUInteger numCardsDiscarded;
	NSUInteger numCardsToDiscard;
	id<GameDelegate> gameDelegate;
	
	Boolean isTrashing;
	NSUInteger numCardsTrashed;
	NSUInteger maxCardsToTrash;
	
	Boolean isGainingCard;
	NSUInteger gainingCardMaxCost;
	
	Boolean needsToChooseActionCard;
}

@property (nonatomic, retain) dominionViewController *controller;
@property (nonatomic, retain) NSMutableArray *handButtons;

@property (nonatomic, retain) NSMutableArray *kingdomDecks;
@property (nonatomic, retain) Deck *estateDeck;
@property (nonatomic, retain) Deck *duchyDeck;
@property (nonatomic, retain) Deck *provinceDeck;
@property (nonatomic, retain) Deck *curseDeck;
@property (nonatomic, retain) Deck *copperDeck;
@property (nonatomic, retain) Deck *silverDeck;
@property (nonatomic, retain) Deck *goldDeck;
@property (nonatomic, retain) Deck *drawDeck;
@property (nonatomic, retain) Deck *cleanupDeck;
@property (nonatomic, retain) Deck *discardDeck;
@property (nonatomic, retain) Deck *trashDeck;

@property (nonatomic, retain) Deck *hand;
@property (nonatomic) NSUInteger actionCount;
@property (nonatomic) NSUInteger buyCount;
@property (nonatomic) NSUInteger coinCount;

@property (nonatomic) TurnState currentState;

@property (nonatomic) Boolean isDiscarding;
@property (nonatomic) NSUInteger numCardsDiscarded;
@property (nonatomic) NSUInteger numCardsToDiscard;
@property (nonatomic, retain) id<GameDelegate> gameDelegate;

@property (nonatomic) Boolean isTrashing;
@property (nonatomic) NSUInteger numCardsTrashed;
@property (nonatomic) NSUInteger maxCardsToTrash;

@property (nonatomic) Boolean isGainingCard;
@property (nonatomic) NSUInteger gainingCardMaxCost;

@property (nonatomic) Boolean needsToChooseActionCard;

- (id) initWithController: (dominionViewController *) theController;

- (void) setButtonText;

- (void) setupGame;

- (Boolean) checkIfPlayAvailableForCurrentTurn;

- (void) doneWithCurrentTurnState;

- (void) drawNewHandFromDeck;
- (void) drawFromDeck: (NSUInteger) numCards;
- (void) drawSingleCardFromDeck;
- (Card *) removeSingleCardFromHandAtIndex: (NSUInteger) index;
- (void) removeSingleCardFromHand: (Card *) card;
- (void) cardRemovedFromHand: (Card *) card;

- (void) cardInHandSelectedAtIndex: (NSUInteger) index;

- (Boolean) canPlayCardInHandAtIndex: (NSUInteger) index;

- (Boolean) buyKingdomCardAtIndex: (NSUInteger) index;
- (Boolean) buyVictoryCard: (VictoryCardTypes) cardType;
- (Boolean) buyTreasureCard: (TreasureCardTypes) cardType;
- (Boolean) canBuyCard: (Card *) card;
- (Boolean) canGainCard: (Card *) card;
- (Boolean) buyCardFromDeck: (Deck *) deck;
- (Card *) gainCardFromDeck: (Deck *) deck;

- (void) playCardInHandAtIndex: (NSUInteger) index;

- (Boolean) isGameOver;

@end
