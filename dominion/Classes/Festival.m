//
//  Festival.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Festival.h"
#import "Game.h"


@implementation Festival

- (NSString *) description {
	return @"+2 Actions, +1 Buy, +2 Coins.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Game *) game {
	game.actionCount += 2;
	game.buyCount++;
	game.coinCount += 2;
	return YES;
}

@end
