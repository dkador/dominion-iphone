//
//  Cellar.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Cellar.h"
#import "Game.h"


@implementation Cellar

- (NSString *) description {
	return @"+1 Action, Discard any number of cards. +1 Card per card discarded.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 2;
}

- (Boolean) takeAction: (Game *) game {
	[self.delegate discardCards:0];
	return YES;
}

- (void) discardFinished: (NSUInteger) numCardsDiscarded InGame: (Game *) game {
	//game.gameDelegate = nil;
	[game drawFromDeck:numCardsDiscarded];
	[self.delegate actionFinished];
}

@end
