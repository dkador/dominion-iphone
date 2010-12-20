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

@synthesize numCardsGained;

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
	game.actionCount++;
	[game drawFromDeck:2];
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	numCardsGained++;
	if (numCardsGained == 2) {
		[self.delegate actionFinished];
	}
}

- (void) couldNotDrawInGame:(Game *)game {
	[self.delegate actionFinished];
}

@end
