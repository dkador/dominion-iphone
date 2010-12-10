//
//  Library.h
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"
#import "Deck.h"

@class Game;

@interface Library : ActionCard {
	Game *theGame;
	Deck *setAsideCards;
	Card *lastDrawnCard;
}

@property (nonatomic, retain) Game *theGame;
@property (nonatomic, retain) Deck *setAsideCards;
@property (nonatomic, retain) Card *lastDrawnCard;

@end
