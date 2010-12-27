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

@synthesize cards, name, faceUp;

- (id) init {
	self = [super init];
	if (self) {
		self.cards = [NSMutableArray arrayWithCapacity:10];
		self.faceUp = YES;
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

- (void) removeCard: (Card *) card {
	NSUInteger index = 0;
	NSUInteger indexToRemove = -1;
	for (Card *aCard in self.cards) {
		if (aCard == card) {
			indexToRemove = index;
			break;
		}
		index++;
	}
	if (indexToRemove >= 0) {
		[self.cards removeObjectAtIndex:indexToRemove];
	}
}

- (void) addCard: (Card *) card {
	[self.cards addObject:card];
}

- (void) sort {
	[self.cards sortUsingSelector:@selector(compare:)];
}

- (void) dealloc {
	// because of earlier hack, if a card is throne room, we have to explicitly release it
	for (Card *card in self.cards) {
		if ([@"Throne Room" isEqualToString:card.name]) {
			[card release];
		}
	}
	[self.cards release];
	[super dealloc];
}

@end
