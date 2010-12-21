//
//  Duchy.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Duchy.h"


@implementation Duchy

- (NSString *) description {
	return @"+3 Victory Points";
}

- (CardType) cardType {
	return Victory;
}

- (NSUInteger) cost {
	return 5;
}

- (NSUInteger) victoryPointsForPlayer:(Player *)player {
	return 3;
}

@end
