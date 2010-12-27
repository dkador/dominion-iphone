//
//  Bureaucrat.m
//  dominion
//
//  Created by Daniel Kador on 12/26/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Bureaucrat.h"
#import "Player.h"


@implementation Bureaucrat

- (NSString *) description {
	return @"Gain a silver card; put it on top of your deck. Each other player reveals a Victory card from his hand and puts it on his deck (or reveals a hand with no Victory cards).";
}

- (CardType) cardType {
	return ActionAttack;
}

- (NSUInteger) cost {
	return 4;
}

- (Boolean) takeAction: (Player *) player {	
	Card *card = [player.game.silverDeck draw];
	if (card) {
		[player.drawDeck addCard:card];
	}
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
}

@end
