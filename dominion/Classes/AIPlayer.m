//
//  AIPlayer.m
//  dominion
//
//  Created by Daniel Kador on 12/31/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "AIPlayer.h"
#import "dominionViewController.h"


@implementation AIPlayer

- (void) startActionPhase {
	// by default do no actions (i.e. click next)
	[self.game doneWithCurrentTurnState];
}

- (void) startBuyPhase {
	if (self.coinCount >= 8) {        // buy a province if I can
		[self.game buyVictoryCard:ProvinceType];
	} else if (self.coinCount >= 6) { // buy a gold if I can
		[self.game buyTreasureCard:GoldType];
	} else if (self.coinCount >= 3) { // buy a silver if I can
		[self.game buyTreasureCard:SilverType]; 
	} else {
		// do nothing!
	}
	[self.game doneWithCurrentTurnState];
}

- (void) startCleanUpPhase {
	[self.game doneWithCurrentTurnState];
}

- (void) promptForReactionCard {	
	// I never buy reaction cards so I don't have one.
	[self.actionDelegate attackPlayerWithRevealedCard:nil];
	// if I did buy...
	/*
	HandViewHelper *theHelper = [[HandViewHelper alloc] initWithDeck:self.hand AndController:self.game.controller];
	self.helper = theHelper;
	[theHelper release];
	self.helper.delegate = self;
	[self.helper displayHandWithMessage:[NSString stringWithFormat:@"Player %@'s revealed hand. Touch here to continue.", self.name]];
	 */
}

- (void) discardDownTo: (NSUInteger) numCards {
	// first discard victory / curse cards, then discard treasure cards in decreasing order of value
	numCardsDiscarded = 0;
	while (self.hand.numCardsLeft > numCards) { //TODO this is pretty inefficient...
		Card *foundCard = nil;
		for (Card *card in self.hand.cards) { // check for victory/curses
			if (card.isVictory || card.isCurse) {
				foundCard = card;
				break;
			}
		}
		if (foundCard) {
			[self.hand removeCard:foundCard];
			[self.discardDeck addCard:foundCard];
			numCardsDiscarded++;
			continue;
		}
		// if we've gotten here it's all treasure, which means we're already sorted by cost...
		Card *card = [self.hand removeCardAtIndex:0];		
		[self.discardDeck addCard:card];
		numCardsDiscarded++;
	}
	[self.gameDelegate discardFinished:numCardsDiscarded ForPlayer:self];
}

- (void) discardOrPutBackTopCard {
	// discard it if it's a victory card, 
}

# pragma mark -
# pragma mark HandViewHelperDelegate implementation

- (void) cardSelected:(Card *)card {
	[self.helper hideEverything];
	self.helper = nil;
	[self.actionDelegate attackPlayerWithRevealedCard:nil];
}

@end
