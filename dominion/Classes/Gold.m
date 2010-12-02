//
//  Gold.m
//  dominion
//
//  Created by Daniel Kador on 11/29/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Gold.h"


@implementation Gold

- (NSString *) description {
	return @"+3 Coins";
}

- (CardType) cardType {
	return Treasure;
}

- (NSUInteger) cost {
	return 6;
}

- (NSUInteger) coins {
	return 3;
}

@end
