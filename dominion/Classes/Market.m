//
//  Market.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Market.h"
#import "Player.h"


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

- (Boolean) takeAction: (Player *) player {
	player.actionCount++;
	player.buyCount++;
	player.coinCount++;
	[player drawFromDeck:1];
	return YES;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	[self.delegate actionFinished];
}

- (void) couldNotDrawForPlayer:(Player *)player {
	[self.delegate actionFinished];
}

@end
