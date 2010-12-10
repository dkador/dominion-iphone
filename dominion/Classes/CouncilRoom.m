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
	[game drawFromDeck:4];
	game.buyCount++;
	//TODO add each other player draws
	return YES;
}

@end
