//
//  Chapel.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Chapel.h"


@implementation Chapel

- (NSString *) description {
	return @"Trash up to 4 cards from your hand.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 2;
}

- (Boolean) takeAction: (Game *) game {
	[self.delegate trashCards:4 WithMessage:self.description];
	return YES;
}

- (void) cardsTrashed: (NSArray *) cards InGame: (Game *) game {
	[self.delegate actionFinished];
}

@end
