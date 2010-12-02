//
//  Village.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Village.h"
#import "Game.h"


@implementation Village

- (NSString *) description {
	return @"+1 Card, +2 Actions.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Game *) game {
	[game drawFromDeck:1];
	game.actionCount += 2;
	[self.delegate actionFinished];
	return YES;
}

@end
