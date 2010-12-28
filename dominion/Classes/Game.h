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
#import "Card.h"
#import "ActionCard.h"
#import "KingdomCards.h"
#import "VictoryCards.h"
#import "TreasureCards.h"

@class dominionViewController;
@class Player;
@class ActionCard;

typedef enum {
	ActionState,
	BuyState,
	CleanupState
} TurnState;

@interface Game : NSObject <ActionDelegate> {
	dominionViewController *controller;
	
	NSMutableArray *kingdomDecks;
	Deck *estateDeck;
	Deck *duchyDeck;
	Deck *provinceDeck;
	Deck *curseDeck;
	Deck *copperDeck;
	Deck *silverDeck;
	Deck *goldDeck;	
	Deck *trashDeck;
	
	NSArray *players;
	NSUInteger currentPlayerIndex;
	
	Boolean isDiscarding;
	NSUInteger numCardsDiscarded;
	NSUInteger numCardsToDiscard;
	
	Boolean isTrashing;
	NSUInteger numCardsTrashed;
	NSUInteger maxCardsToTrash;
	
	Boolean isGainingCard;
	NSUInteger gainingCardMaxCost;
	
	Boolean needsToChooseActionCard;
	
	NSUInteger currentPlayerIndexToAttack;
	ActionCard *currentAttackCard;
}

@property (nonatomic, retain) dominionViewController *controller;

@property (nonatomic, retain) NSMutableArray *kingdomDecks;
@property (nonatomic, retain) Deck *estateDeck;
@property (nonatomic, retain) Deck *duchyDeck;
@property (nonatomic, retain) Deck *provinceDeck;
@property (nonatomic, retain) Deck *curseDeck;
@property (nonatomic, retain) Deck *copperDeck;
@property (nonatomic, retain) Deck *silverDeck;
@property (nonatomic, retain) Deck *goldDeck;
@property (nonatomic, retain) Deck *trashDeck;

@property (nonatomic, retain) NSArray *players;
@property (nonatomic) NSUInteger currentPlayerIndex;
@property (readonly) Player *currentPlayer;

@property (nonatomic) Boolean isDiscarding;
@property (nonatomic) NSUInteger numCardsDiscarded;
@property (nonatomic) NSUInteger numCardsToDiscard;

@property (nonatomic) Boolean isTrashing;
@property (nonatomic) NSUInteger numCardsTrashed;
@property (nonatomic) NSUInteger maxCardsToTrash;

@property (nonatomic) Boolean isGainingCard;
@property (nonatomic) NSUInteger gainingCardMaxCost;

@property (nonatomic) Boolean needsToChooseActionCard;

@property (nonatomic) NSUInteger currentPlayerIndexToAttack;
@property (nonatomic, retain) ActionCard *currentAttackCard;

- (id) initWithController: (dominionViewController *) theController;

- (void) setInfoLabel: (NSString *) text;
- (void) setButtonText;

- (void) setupGame;
- (void) cleanUpGame;

- (Boolean) checkIfPlayAvailableForCurrentTurn;

- (void) doneWithCurrentTurnState;

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
- (void) attackPlayerWithRevealedCard: (NSString *) name;

- (Boolean) isGameOver;

@end
