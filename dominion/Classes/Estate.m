//
//  Estate.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Estate.h"


@implementation Estate

- (NSString *) description {
	return @"+1 Victory Point";
}

- (CardType) cardType {
	return Victory;
}

- (NSUInteger) cost {
	return 2;
}

- (NSUInteger) victoryPointsForPlayer:(Player *)player {
	return 1;
}

@end
