//
//  Village.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Village.h"
#import "Player.h"


@implementation Village

- (NSString *) description {
	return @"+1 Card, +2 Actions.";
}

- (CardType) cardType {
	return Action;
}

- (NSUInteger) cost {
	return 3;
}

- (Boolean) takeAction: (Player *) player {
	player.actionCount += 2;
	[player drawFromDeck:1];
	return YES;
}

# pragma mark -
# pragma mark GameDelegate implementation

- (void) cardGained:(Card *)card {
	[self.delegate actionFinished];
}

- (void) couldNotDrawForPlayer:(Player *)player {
	[self.delegate actionFinished];
}


@end
