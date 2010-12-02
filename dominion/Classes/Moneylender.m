//
//  Moneylender.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Moneylender.h"
#import "Game.h"


@implementation Moneylender

@synthesize theGame;

- (NSString *) description {
	return @"Trash a Copper from your hand. If you do, +3 Coins.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 4;
}

// TODO this is probably not exactly right - you shouldn't even be able to play this if you don't have copper.
- (Boolean) takeAction: (Game *) game {
	// first check to see if there are any copper available
	NSInteger copperIndex = -1;
	NSInteger i = 0;
	for (Card *card in game.hand.cards) {
		if ([card.name isEqual:@"Copper"]) {
			copperIndex = i;
			break;
		}
		i++;
	}
	UIAlertView *alert;
	if (copperIndex == -1) {
		alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You have no copper in hand to trash." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	} else {
		self.theGame = game;
		alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to trash a copper from your hand?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	}
	[alert show];
	[alert release];
	return YES;
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (self.theGame) {
		if (buttonIndex == 1) {
			NSInteger index = 0;
			int i = 0;
			for (Card *card in self.theGame.hand.cards) {
				if ([card.name isEqual:@"Copper"]) {
					index = i;
					break;
				}
				i++;
			}
			Card *card = [self.theGame.hand removeCardAtIndex:index];
			[self.theGame.trashDeck addCard:card];
			self.theGame.coinCount += 2; // plus 3 from the action, -1 from the loss of copper
		}
		[self.theGame checkIfPlayAvailableForCurrentTurn];
		[self.theGame setButtonText];
		self.theGame = nil;
	}
	[self.delegate actionFinished];
}


@end