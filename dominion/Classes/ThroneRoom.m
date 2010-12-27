//
//  ThroneRoom.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "ThroneRoom.h"
#import "Player.h"


@implementation ThroneRoom

@synthesize thePlayer, gameDelegate, theAction, executedOnce;

- (NSString *) name {
	return @"Throne Room";
}

- (NSString *) description {
	return @"Choose an Action card in your hand. Play it twice.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {
	[self.delegate chooseActionCard];
	return YES;
}

- (void) actionCardSelected:(Card *)card ForPlayer:(Player *)player {
	self.thePlayer = player;	
	ActionCard *actionCard = (ActionCard *) card;
	self.theAction = actionCard;
	actionCard.delegate = self;
	self.gameDelegate = actionCard;
	self.thePlayer.gameDelegate = actionCard;
	[player.game setButtonText];
	[actionCard takeAction:player];
}

- (void) dealloc {
	self.thePlayer = nil;
	self.gameDelegate = nil;
	self.theAction = nil;
	[super dealloc];
}

# pragma mark -
# pragma mark ActionDelegate Implementation

- (void) discardCards: (NSUInteger) numberOfCardsToDiscard {
	[self.thePlayer.game discardCards:numberOfCardsToDiscard];
}

- (void) trashCards: (NSUInteger) numberOfCardsToTrash WithMessage: (NSString *) message {
	[self.thePlayer.game trashCards:numberOfCardsToTrash WithMessage:message];
}

- (void) gainCardCostingUpTo: (NSUInteger) maxCost {
	[self.thePlayer.game gainCardCostingUpTo:maxCost];
}

- (void) chooseActionCard {
	[self.thePlayer.game chooseActionCard];
}

- (void) actionFinished {
	if (!self.executedOnce) {
		NSLog(@"Throne room executing for first time.");
		self.executedOnce = YES;
		self.theAction.delegate = self;
		self.gameDelegate = self.theAction;
		self.thePlayer.gameDelegate = self.theAction;
		[self.thePlayer.game setButtonText];
		[self.theAction takeAction:self.thePlayer];
	} else {
		NSLog(@"Throne room executing for second time.");
		[self.thePlayer.game setButtonText];
		self.executedOnce = NO;
		self.theAction = nil;
		[self.delegate actionFinished];
		self.delegate = nil;
		self.thePlayer = nil;
	}
}

- (void) attackFinished {
	
}

- (void) attackFinishedOnPlayer {
}

@end
