//
//  Silver.m
//  dominion
//
//  Created by Daniel Kador on 11/29/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Silver.h"


@implementation Silver

- (NSString *) description {
	return @"+2 Coins";
}

- (CardType) cardType {
	return Treasure;
}

- (NSUInteger) cost {
	return 3;
}

- (NSUInteger) coins {
	return 2;
}

@end
