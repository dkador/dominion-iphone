//
//  Moat.m
//  dominion
//
//  Created by Daniel Kador on 12/23/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Moat.h"
#import "Player.h"


@implementation Moat

@synthesize numCardsGained;

- (NSString *) description {
	return @"+2 Cards. When another players plays an Attack card, you may reveal this from your hand. If you do, you are unaffected by that Attack.";
}

- (CardType) cardType {
	return ActionReaction;
}

- (NSUInteger) cost {
	return 2;
}

- (Boolean) takeAction: (Player *) player {
	[player drawFromDeck:2];	
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	numCardsGained++;
	if (numCardsGained == 2) {
		self.numCardsGained = 0;
		[self.delegate actionFinished];
	}
}

- (void) couldNotDrawForPlayer:(Player *)player {
	self.numCardsGained = 0;
	[self.delegate actionFinished];
}

@end
