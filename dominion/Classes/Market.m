//
//  Market.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Market.h"
#import "Game.h"


@implementation Market

- (NSString *) description {
	return @"+1 Card, +1 Action, +1 Buy, +1 Coin.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Game *) game {
	[game drawFromDeck:1];
	game.actionCount++;
	game.buyCount++;
	game.coinCount++;
	return YES;
}

@end
