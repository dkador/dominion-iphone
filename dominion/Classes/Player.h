//
//  Player.h
//  dominion
//
//  Created by Daniel Kador on 12/20/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "ActionDelegate.h"


@class Deck;
@class Card;

@interface Player : NSObject {
	NSString *name;
	Deck *hand;
	Deck *drawDeck;
	Deck *cleanupDeck;
	Deck *discardDeck;
	Deck *trashDeck;
	
	TurnState currentState;
	NSUInteger actionCount;
	NSUInteger buyCount;
	NSUInteger coinCount;
	
	Game *game;
	id<GameDelegate> gameDelegate;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) Deck *hand;
@property (nonatomic, retain) Deck *drawDeck;
@property (nonatomic, retain) Deck *cleanupDeck;
@property (nonatomic, retain) Deck *discardDeck;
@property (nonatomic, retain) Deck *trashDeck;

@property (nonatomic) TurnState currentState;
@property (nonatomic) NSUInteger actionCount;
@property (nonatomic) NSUInteger buyCount;
@property (nonatomic) NSUInteger coinCount;

@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) id<GameDelegate> gameDelegate;

- (void) drawNewHandFromDeck;
- (void) drawFromDeck: (NSUInteger) numCards;
- (Boolean) drawSingleCardFromDeck;
- (Card *) removeSingleCardFromHandAtIndex: (NSUInteger) index;
- (void) removeSingleCardFromHand: (Card *) card;
- (void) cardRemovedFromHand: (Card *) card;


@end