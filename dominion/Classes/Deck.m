//
//  Deck.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "Deck.h"
#import <stdlib.h>


@implementation Deck

@synthesize cards, name;

- (id) init {
	self = [super init];
	if (self) {
		self.cards = [NSMutableArray arrayWithCapacity:10];
	}
	return self;
}

# pragma mark -
# pragma mark Properies

- (NSInteger) numCardsLeft {
	return [self.cards count];
}

# pragma mark -
# pragma mark Implementation

- (void) shuffle {
    // i is the number of items remaining to be shuffled.
	for (NSInteger i = [self.cards count]; i > 1; i--) {
        // Pick a random element to swap with the i-th element.
		int j = arc4random() % i; // 0 <= j <= i-1 (0-based array)
		// Swap array elements.
		Card *temp = [self.cards objectAtIndex:j];
		[self.cards replaceObjectAtIndex:j withObject:[self.cards objectAtIndex:i-1]];
		[self.cards replaceObjectAtIndex:i-1 withObject:temp];
 	}
}

- (Card *) draw {
	Card* card = [[[self.cards lastObject] retain] autorelease];
	if (card) {
		[self.cards removeLastObject];
	}
	return card;
}

- (Card *) peek {
	return [self.cards lastObject];
}

- (Card *) cardAtIndex: (NSUInteger) index {
	return [self.cards objectAtIndex:index];
}

- (Card *) removeCardAtIndex: (NSUInteger) index {
	Card *card = [self.cards objectAtIndex:index];
	[self.cards removeObjectAtIndex:index];
	return card;
}

- (void) addCard: (Card *) card {
	[self.cards addObject:card];
}

- (void) sort {
	[self.cards sortUsingSelector:@selector(compare:)];
}

- (void) dealloc {
	[self.cards release];
	[super dealloc];
}

@end
