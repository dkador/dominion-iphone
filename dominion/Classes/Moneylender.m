//
//  Moneylender.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Moneylender.h"
#import "Player.h"
#import "Game.h"


@implementation Moneylender

@synthesize thePlayer;

- (NSString *) description {
	return @"Trash a Copper from your hand. If you do, +3 Coins.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {
	// first check to see if there are any copper available
	NSInteger copperIndex = -1;
	NSInteger i = 0;
	for (Card *card in player.hand.cards) {
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
		self.thePlayer = player;
		alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to trash a copper from your hand?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	}
	[alert show];
	[alert release];
	return YES;
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (self.thePlayer) {
		if (buttonIndex == 1) {
			NSInteger index = 0;
			int i = 0;
			for (Card *card in self.thePlayer.hand.cards) {
				if ([card.name isEqual:@"Copper"]) {
					index = i;
					break;
				}
				i++;
			}
			Card *card = [self.thePlayer.hand removeCardAtIndex:index];
			[self.thePlayer.game.trashDeck addCard:card];
			self.thePlayer.coinCount += 2; // plus 3 from the action, -1 from the loss of copper
		}
		[self.thePlayer.game checkIfPlayAvailableForCurrentTurn];
		[self.thePlayer.game setButtonText];
		self.thePlayer = nil;
	}
	[self.delegate actionFinished];
}

@end
