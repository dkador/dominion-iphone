//
//  Smithy.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Smithy.h"
#import "Game.h"


@implementation Smithy

- (NSString *) description {
	return @"+3 Cards.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Game *) game {
	[game drawFromDeck:3];
	[game setButtonText];
	return YES;
	[self.delegate actionFinished];
}

@end
