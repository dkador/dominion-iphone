//
//  Bureaucrat.m
//  dominion
//
//  Created by Daniel Kador on 12/26/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Bureaucrat.h"
#import "Player.h"
#import "Game.h"


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
	[self.delegate actionFinished];
	return NO;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) attackPlayer: (Player *) player {
	// if a player has a victory card in hand, they're required to reveal it and move it to the top of their deck
	Card *victoryCard;
	for (Card* card in player.hand.cards) {
		if (card.isVictory) {
			victoryCard = card;
			break;
		}
	}
	// cool, we found it
	if (victoryCard) {
		[player.hand removeCard:victoryCard];
		[player.drawDeck addCard:victoryCard];
		[player.game setInfoLabel:[NSString stringWithFormat:@"%@ revealed %@.", player.name, victoryCard.name]];
	} else {
		// reveal whole hand.
		// build a string of cards.
		NSString *message = [NSString stringWithFormat:@"%@ revealed a hand with no victory cards: ", player.name];
		NSUInteger count = 0;
		for (Card *card in player.hand.cards) {
			if (count > 0) {
				message = [message stringByAppendingString:@", "];
			}
			message = [message stringByAppendingString:card.name];
			count++;
		}
		[player.game setInfoLabel:message];
	}
	[self.delegate attackFinishedOnPlayer];
}

@end
