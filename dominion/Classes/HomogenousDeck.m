//
//  HomogenousDeck.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "HomogenousDeck.h"


@implementation HomogenousDeck

@synthesize card, count;

# pragma mark -
# pragma mark Properies

- (NSInteger) numCardsLeft {
	return self.count;
}

# pragma mark -
# pragma mark Implementation

- (id) initWithCard: (Card *) theCard AndNumber: (NSUInteger ) num {
	self = [super init];
	if (self) {
		self.card = theCard;
		self.count = num;
	}
	return self;
}

- (void) shuffle {
	// If all the cards are the same, there's no reason to shuffle.
}

- (Card *) draw {
	self.count--;
	return card;
}

- (Card *) peek {
	return card;
}

- (void) addCard: (Card *) card {
	self.count++;
}

- (NSString *) name {
	return self.card.name;
}

- (void) dealloc {
	self.card = nil;
	[super dealloc];
}

@end
