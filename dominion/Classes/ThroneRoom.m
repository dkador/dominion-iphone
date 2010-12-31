//
//  ThroneRoom.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "ThroneRoom.h"
#import "Player.h"
#import "Game.h"


@implementation ThroneRoom

@synthesize thePlayer, gameDelegate, theAction, executedOnce;
@synthesize currentPlayerIndexToAttack, currentAttackCard;

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
	NSLog(@"ThroneRoom: %@ selected", card.name);
	self.thePlayer = player;	
	ActionCard *actionCard = (ActionCard *) card;
	self.theAction = actionCard;
	actionCard.delegate = self;
	self.gameDelegate = actionCard;
	self.thePlayer.gameDelegate = actionCard;
	self.currentAttackCard = actionCard;
	// TODO does it really make sense to have to muck with every player's delegate?
	for (Player *aPlayer in player.game.players) {
		aPlayer.actionDelegate = self;
	}
	[player.game setButtonText];
	NSLog(@"Throne Room: Taking action");
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
	NSLog(@"Throne Room: Action finished");
	if (self.theAction.isAttack) {
		// loop through all players, starting with player after current player, going up to player before current player
		self.currentPlayerIndexToAttack = self.thePlayer.game.currentPlayerIndex + 1;
		if (self.currentPlayerIndexToAttack == [self.thePlayer.game.players count]) {
			self.currentPlayerIndexToAttack = 0; // wrap around if the current player is the last player
		}
		if (self.currentPlayerIndexToAttack != self.thePlayer.game.currentPlayerIndex) {
			// see if player has a reaction card so attack ignores them
			NSLog(@"Throne Room: Attacking player %d for first time", self.currentPlayerIndexToAttack);
			[[self.thePlayer.game.players objectAtIndex:self.currentPlayerIndexToAttack] promptForReactionCard];
		}
	} else {
		NSLog(@"Throne Room: Action card was NOT an attack");
		[self attackFinished];
	}
}

- (void) attackPlayerWithRevealedCard: (NSString *) name {
	NSLog(@"Throne Room: Attack player %d with revealed card", self.currentPlayerIndexToAttack);
	if (name) {
		// a card was revealed, so show it
		[self.thePlayer.game setInfoLabel:[NSString stringWithFormat:@"%@ revealed by %@.", name, [[self.thePlayer.game.players objectAtIndex:self.currentPlayerIndexToAttack] name]]];
		[self attackFinishedOnPlayer];
	} else {
		// no card was revealed.  ATTACK!
		[self.currentAttackCard attackPlayer:[self.thePlayer.game.players objectAtIndex:self.currentPlayerIndexToAttack]];
	}
}

- (void) attackFinishedOnPlayer {
	NSLog(@"Throne Room: attack finished on player %d", self.currentPlayerIndexToAttack);
	// move on to next player
	self.currentPlayerIndexToAttack++;
	if (self.currentPlayerIndexToAttack == [self.thePlayer.game.players count]) {
		self.currentPlayerIndexToAttack = 0; // wrap around if the current player is the last player
	}
	// is there more to do (i.e. are we not back to current player)?
	if (self.currentPlayerIndexToAttack != self.thePlayer.game.currentPlayerIndex) {
		NSLog(@"Throne Room: Attacking next player (player %d) in order", self.currentPlayerIndexToAttack);
		Player *attackee = [self.thePlayer.game.players objectAtIndex:self.currentPlayerIndexToAttack];
		[attackee promptForReactionCard];
	} else {
		// okay, attack is finished, hooray!
		[self attackFinished];
	}
}

- (void) attackFinished {
	if (!self.executedOnce) {
		NSLog(@"Throne room executed for first time.");
		self.executedOnce = YES;
		self.theAction.delegate = self;
		self.gameDelegate = self.theAction;
		self.thePlayer.gameDelegate = self.theAction;
		[self.thePlayer.game setButtonText];
		[self.theAction takeAction:self.thePlayer];	
	} else {
		NSLog(@"Throne room executed for second time.");
		[self.thePlayer.game setInfoLabel:[NSString stringWithFormat:@"%@ Throne Roomed.", self.theAction.name]];
		[self.thePlayer.game setButtonText];
		self.executedOnce = NO;
		self.theAction = nil;
		self.thePlayer.gameDelegate = self;
		[self.delegate actionFinished];
		self.delegate = nil;
		self.thePlayer = nil;
		self.currentAttackCard = nil;
	}

}

@end
