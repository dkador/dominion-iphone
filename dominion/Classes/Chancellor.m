//
//  Chancellor.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Chancellor.h"
#import "Game.h"


@implementation Chancellor

@synthesize theGame;

- (NSString *) description {
	return @"+2 Coins, You may immediately put your deck into your discard pile.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 3;
}

- (Boolean) takeAction: (Game *) game {
	self.theGame = game;
	game.coinCount += 2;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to put your desk into the discard pile?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
	[alert release];
	return YES;
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		// move deck to discard
		while (self.theGame.drawDeck.numCardsLeft > 0) {
			Card *card = [self.theGame.drawDeck draw];
			[self.theGame.discardDeck addCard:card];
		}
	}
	[self.theGame setButtonText];
	self.theGame = nil;
	[self.delegate actionFinished];
}

@end
