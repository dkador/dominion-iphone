//
//  Woodcutter.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Woodcutter.h"
#import "Game.h"


@implementation Woodcutter

- (NSString *) description {
	return @"+1 Buy, +2 Coins";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 3;
}

- (Boolean) takeAction: (Game *) game {
	game.buyCount++;
	game.coinCount += 2;
	[game setButtonText];
	[self.delegate actionFinished];
	return YES;
}

@end
