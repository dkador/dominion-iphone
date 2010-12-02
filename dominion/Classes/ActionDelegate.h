//
//  ActionDelegate.h
//  dominion
//
//  Created by Daniel Kador on 11/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Card;

@protocol ActionDelegate

- (void) discardCards: (NSUInteger) numberOfCardsToDiscard;
- (void) trashCards: (NSUInteger) numberOfCardsToTrash WithMessage: (NSString *) message;
- (void) gainCardCostingUpTo: (NSUInteger) maxCost;
- (void) chooseActionCard;

- (void) actionFinished;

@end
