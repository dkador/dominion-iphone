//
//  Thief.h
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"
#import "HandViewHelper.h"


@class Player;
@class Card;

@interface Thief : ActionCard <HandViewHelperDelegate, UIAlertViewDelegate> {
	Player *thePlayer;
	NSMutableArray *revealedCards;
	Card *trashedCard;
	HandViewHelper *helper;
}

@property (nonatomic, retain) Player *thePlayer;
@property (nonatomic, retain) NSMutableArray *revealedCards;
@property (nonatomic, retain) Card *trashedCard;
@property (nonatomic, retain) HandViewHelper *helper;

@end
