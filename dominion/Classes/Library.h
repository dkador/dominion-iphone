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

@class Player;

@interface Library : ActionCard {
	Player *thePlayer;
	Deck *setAsideCards;
	Card *lastDrawnCard;
}

@property (nonatomic, retain) Player *thePlayer;
@property (nonatomic, retain) Deck *setAsideCards;
@property (nonatomic, retain) Card *lastDrawnCard;

@end
