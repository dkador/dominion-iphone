//
//  CouncilRoom.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "CouncilRoom.h"
#import "Game.h"


@implementation CouncilRoom

@synthesize numCardsGained;

- (NSString *) name {
	return @"Council Room";
}

- (NSString *) description {
	return @"+4 Cards, +1 Buy, Each other player draws a card.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Game *) game {
	game.buyCount++;
	//TODO add each other player draws
	[game drawFromDeck:4];
	return YES;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	numCardsGained++;
	if (numCardsGained == 4) {
		[self.delegate actionFinished];
	}
}

- (void) couldNotDrawInGame:(Game *)game {
	[self.delegate actionFinished];
}

@end
