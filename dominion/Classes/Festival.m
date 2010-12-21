//
//  Festival.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Festival.h"
#import "Player.h"


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

- (Boolean) takeAction: (Player *) player {
	player.actionCount += 2;
	player.buyCount++;
	player.coinCount += 2;
	[self.delegate actionFinished];
	return YES;
}

@end
