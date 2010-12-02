//
//  Remodel.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Remodel.h"


@implementation Remodel

- (NSString *) description {
	return @"Trash a card from your hand. Gain a card costing up to 2 Coins more than the trashed card.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Game *) game {
	[self.delegate trashCards:1 WithMessage:@"Trash a single card from your hand."];
	return YES;
}

#pragma mark -
#pragma mark GameDelegate methods

- (void) cardsTrashed:(NSArray *)cards InGame:(Game *)game {
	Card *trashed = [cards objectAtIndex:0];
	[self.delegate gainCardCostingUpTo:trashed.cost + 2];
	[self.delegate actionFinished];
}

@end
