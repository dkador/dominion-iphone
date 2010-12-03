//
//  Curse.m
//  dominion
//
//  Created by Daniel Kador on 11/29/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Curse.h"


@implementation Curse

- (NSString *) description {
	return @"-1 Victory Point";
}

- (CardType) cardType {
	return Victory;
}

- (NSUInteger) cost {
	return 0;
}

- (NSUInteger) victoryPointsInGame: (Game *) game {
	return -1;
}

@end
