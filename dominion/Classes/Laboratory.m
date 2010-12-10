//
//  Laboratory.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Laboratory.h"
#import "Game.h"


@implementation Laboratory

- (NSString *) description {
	return @"+2 Cards, +1 Action.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Game *) game {
	[game drawFromDeck:2];
	game.actionCount++;
	return YES;
}

@end
