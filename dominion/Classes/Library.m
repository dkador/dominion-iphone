//
//  Library.m
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Library.h"
#import "Player.h"


@implementation Library

@synthesize thePlayer, setAsideCards, lastDrawnCard;

- (NSString *) description {
	return @"Draw until you have 7 cards in hand. You may set aside any Action cards drawn this way, as you draw them; discard the set aside cards after you finish drawing.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 5;
}

- (Boolean) takeAction: (Player *) player {
	self.thePlayer = player;
	player.gameDelegate = self;
	self.setAsideCards = [[Deck alloc] init];
	[player drawFromDeck:1];
	return NO;
}

- (void) checkIfDone {
	// do we have seven cards in hand?
	if (self.thePlayer.hand.numCardsLeft == 7) {
		// ok, we're done, move set aside cards to discard
		Card *card;
		while ((card = [self.setAsideCards draw])) {
			[self.thePlayer.discardDeck addCard:card]; // I think this is right - the rules say the card goes straight to discard, not cleanup
		}		 
		 
		// now release all references
		self.thePlayer = nil;
		self.setAsideCards = nil;
		self.lastDrawnCard = nil;
		[self.delegate actionFinished];
		self.delegate = nil;
	} else {
		// we're not done, draw again
		[self.thePlayer drawFromDeck:1];
	}
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained: (Card *) card {
	self.lastDrawnCard = card;
	// is card an action card?
	if (card.isAction) {
		// it is. now let user decide if they want to set it aside or keep it.
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Do you want to set aside %@?", card.name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		[alert show];
		[alert release];
	} else {
		[self checkIfDone];
	}
}

# pragma mark -
# pragma mark UIAlertViewDelegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		// move card from hand to set aside cards
		[self.thePlayer.hand removeCard:self.lastDrawnCard];
		[self.setAsideCards addCard:self.lastDrawnCard];
		self.lastDrawnCard = nil;
	} 
	// now check if we're done
	[self checkIfDone];
}

@end
