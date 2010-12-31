//
//  AIPlayer.m
//  dominion
//
//  Created by Daniel Kador on 12/31/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "AIPlayer.h"


@implementation AIPlayer

- (void) startActionPhase {
	// by default do no actions (i.e. click next)
	[self.game doneWithCurrentTurnState];
}

- (void) startBuyPhase {
	if (self.buyCount >= 8) {        // buy a province if I can
		[self.game buyVictoryCard:ProvinceType];
	} else if (self.buyCount >= 6) { // buy a gold if I can
		[self.game buyTreasureCard:GoldType];
	} else if (self.buyCount >= 3) { // buy a silver if I can
		[self.game buyTreasureCard:SilverType]; 
	} else {
		// do nothing!
	}
	[self.game doneWithCurrentTurnState];
}

- (void) startCleanUpPhase {
	[self.game doneWithCurrentTurnState];
}

@end
