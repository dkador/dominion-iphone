//
//  Chapel.m
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Chapel.h"
#import "Player.h"


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

- (Boolean) takeAction: (Player *) player {
	[self.delegate trashCards:4 WithMessage:self.description];
	return YES;
}

- (void) cardsTrashed:(NSArray *)cards ForPlayer:(Player *)player {
	[self.delegate actionFinished];
}

@end
