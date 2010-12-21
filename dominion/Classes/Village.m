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
	return 3;
}

- (Boolean) takeAction: (Game *) game {
	game.actionCount += 2;
	[game drawFromDeck:1];
	return YES;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	[self.delegate actionFinished];
}

- (void) couldNotDrawInGame:(Game *)game {
	[self.delegate actionFinished];
}


@end
