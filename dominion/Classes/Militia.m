//
//  Militia.m
//  dominion
//
//  Created by Daniel Kador on 12/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Militia.h"
#import "Player.h"
#import "Game.h"
#import "dominionViewController.h"
#import "HandViewHelper.h"


@implementation Militia

@synthesize thePlayer, helper;

- (NSString *) description {
	return @"+2 Coins, Each other player discards down to 3 cards in his hand.";
}

- (CardType) cardType {
	return ActionAttack;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {
	player.coinCount += 2;
	[self.delegate actionFinished];
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
	[player discardDownTo:3];
}

- (void) discardFinished:(NSUInteger)numCardsDiscarded ForPlayer:(Player *)player {
	[self.delegate attackFinishedOnPlayer];
}

# pragma mark -
# pragma mark HandViewHelperDelegate implementation

- (void) cardSelected:(Card *)card {
	[self.helper hideEverything];
	
	[self.thePlayer.hand removeCard:card];
	[self.thePlayer.discardDeck addCard:card];
		
	[self attackPlayer:self.thePlayer];
}

@end
