//
//  Spy.h
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"


@class Player;
@class Card;

@interface Spy : ActionCard {
	Player *thePlayer;
	Card *revealedCard;
}

@property (nonatomic, retain) Player *thePlayer;
@property (nonatomic, retain) Card *revealedCard;

@end
