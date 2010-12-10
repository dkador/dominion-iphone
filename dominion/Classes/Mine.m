//
//  Mine.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Mine.h"
#import "Game.h"


@implementation Mine

@synthesize costAllowed;

- (NSString *) description {
	return @"Trash a Treasure card from your hand. Gain a Treasure card costing up to 3 Coins more; put it into your hand.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Game *) game {
	// if there are no treasure cards in hand, let the user know and move on.
	Boolean hasTreasureInHand = NO;
	for (Card *card in game.hand.cards) {
		if (card.isTreasure) {
			hasTreasureInHand = YES;
			break;
		}
	}
	if (hasTreasureInHand) {
		self.costAllowed = 0;
		[self.delegate trashCards:1 WithMessage:@"Trash a treasure card from your hand."];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You have no treasure cards in hand to trash." delegate:self cancelButtonTitle:@"Oops." otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (Boolean) isTrashAllowed: (Card *) card InGame: (Game *) game {
	return card.cardType == Treasure;
}

- (void) cardsTrashed: (NSArray *) cards InGame: (Game *) game {
	// we know we'll only get here if a treasure has been trashed.
	self.costAllowed = [[cards objectAtIndex:0] cost] + 3;
	[self.delegate gainCardCostingUpTo:self.costAllowed];
}

- (Boolean) isGainAllowed: (Card *) card InGame: (Game *) game {
	return card.isTreasure;
}

- (void) cardGained: (Card *) card {
	self.costAllowed = 0;
	[self.delegate actionFinished];
	self.delegate = nil;
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self.delegate actionFinished];
}

@end
