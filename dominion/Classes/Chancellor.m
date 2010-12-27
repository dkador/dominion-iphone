//
//  Chancellor.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Chancellor.h"
#import "Player.h"


@implementation Chancellor

@synthesize thePlayer;

- (NSString *) description {
	return @"+2 Coins, You may immediately put your deck into your discard pile.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 3;
}

- (Boolean) takeAction: (Player *) player {
	self.thePlayer = player;
	player.coinCount += 2;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to put your desk into the discard pile?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];
	return NO;
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		// move deck to discard
		while (self.thePlayer.drawDeck.numCardsLeft > 0) {
			Card *card = [self.thePlayer.drawDeck draw];
			[self.thePlayer.discardDeck addCard:card];
		}
	}
	[self.thePlayer.game setButtonText];
	self.thePlayer = nil;
	[self.delegate actionFinished];
}

@end
