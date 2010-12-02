//
//  ThroneRoom.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "ThroneRoom.h"
#import "Game.h"


@implementation ThroneRoom

@synthesize theGame, gameDelegate, theAction, executedOnce;

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

- (Boolean) takeAction: (Game *) game {
	[self.delegate chooseActionCard];
	return YES;
}

- (void) actionCardSelected: (Card *) card InGame: (Game *) game {
	self.theGame = game;	
	ActionCard *actionCard = (ActionCard *) card;
	self.theAction = actionCard;
	actionCard.delegate = self;
	self.gameDelegate = actionCard;
	self.theGame.gameDelegate = actionCard;
	[game setButtonText];
	[actionCard takeAction:game];
}

# pragma mark -
# pragma mark ActionDelegate Implementation

- (void) discardCards: (NSUInteger) numberOfCardsToDiscard {
	[self.theGame discardCards:numberOfCardsToDiscard];
}

- (void) trashCards: (NSUInteger) numberOfCardsToTrash WithMessage: (NSString *) message {
	[self.theGame trashCards:numberOfCardsToTrash WithMessage:message];
}

- (void) gainCardCostingUpTo: (NSUInteger) maxCost {
	[self.theGame gainCardCostingUpTo:maxCost];
}

- (void) chooseActionCard {
	[self.theGame chooseActionCard];
}

- (void) actionFinished {
	if (!self.executedOnce) {
		self.executedOnce = YES;
		self.theAction.delegate = self;
		self.gameDelegate = self.theAction;
		self.theGame.gameDelegate = self.theAction;
		[self.theGame setButtonText];
		[self.theAction takeAction:self.theGame];
	} else {
		self.executedOnce = NO;
		self.theAction = nil;
		self.delegate = nil;
		[self.theGame actionFinished];
		self.theGame = nil;
	}
}

@end
