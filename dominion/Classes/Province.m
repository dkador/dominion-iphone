//
//  Province.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Province.h"


@implementation Province

- (NSString *) description {
	return @"+6 Victory Points";
}

- (CardType) cardType {
	return Victory;
}

- (NSUInteger) cost {
	return 8;
}

- (NSUInteger) victoryPointsInGame: (Game *) game {
	return 6;
}

@end
