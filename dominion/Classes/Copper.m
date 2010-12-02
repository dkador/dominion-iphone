//
//  Copper.m
//  dominion
//
//  Created by Daniel Kador on 11/29/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Copper.h"


@implementation Copper

- (NSString *) description {
	return @"+1 Coin";
}

- (CardType) cardType {
	return Treasure;
}

- (NSUInteger) cost {
	return 0;
}

- (NSUInteger) coins {
	return 1;
}

@end
