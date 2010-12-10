//
//  Adventurer.h
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"
#import "Deck.h"


@interface Adventurer : ActionCard {
	Game *theGame;
	NSUInteger numTreasuresFound;
	Deck *revealedCards;
}

@property (nonatomic, retain) Game *theGame;
@property (nonatomic) NSUInteger numTreasuresFound;
@property (nonatomic, retain) Deck *revealedCards;

@end
