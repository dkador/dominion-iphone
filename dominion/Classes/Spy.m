//
//  Spy.m
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Spy.h"
#import "Player.h"
#import "Card.h"


@implementation Spy

@synthesize thePlayer, revealedCard;

- (NSString *) description {
	return @"1 Card, +1 Action, Each player (including you) reveals the top card of his deck and either discards it or puts it back, your choice.";
}

- (CardType) cardType {
	return ActionAttack;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {	
	self.thePlayer = player;
	player.actionCount++;
	[player drawFromDeck:1];
	return NO;
}

- (void) revealTopCardForPlayer: (Player *) player {
	[player discardOrPutBackTopCard];
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
	self.thePlayer = player;
	[self revealTopCardForPlayer:player];
}

- (void) cardGained:(Card *)card {
	[self revealTopCardForPlayer:self.thePlayer];
}

- (void) couldNotDrawForPlayer:(Player *)player {
	[self revealTopCardForPlayer:self.thePlayer];
}

- (void) discardFinished:(NSUInteger)numCardsDiscarded ForPlayer:(Player *)player {
	[self.delegate attackFinished];
}

@end
