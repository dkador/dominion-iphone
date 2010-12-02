//
//  KingdomCards.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <stdlib.h>
#import "KingdomCards.h"
#import "HomogenousDeck.h"


static KingdomCards *sharedInstance = nil;

@implementation KingdomCards

# pragma mark -
# pragma mark Singleton methods

+ (KingdomCards *) sharedInstance {
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [[KingdomCards alloc] init];
		}
	}
	return sharedInstance;
}

+ (id) allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedInstance == nil) {
			sharedInstance = [super allocWithZone:zone];
			return sharedInstance;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (unsigned)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

# pragma mark -
# pragma mark Property methods

- (Cellar *) cellar {
	if (!cellar) {
		cellar = [[[Cellar alloc] init] retain];
	}
	return cellar;
}

- (Chancellor *) chancellor {
	if (!chancellor) {
		chancellor = [[[Chancellor alloc] init] retain];
	}
	return chancellor;
}

- (Chapel *) chapel {
	if (!chapel) {
		chapel = [[[Chapel alloc] init] retain];
	}
	return chapel;
}

- (Feast *) feast {
	if (!feast) {
		feast = [[[Feast alloc] init] retain];
	}
	return feast;
}

- (Gardens *) gardens {
	if (!gardens) {
		gardens = [[[Gardens alloc] init] retain];
	}
	return gardens;
}

- (Moneylender *) moneylender {
	if (!moneylender) {
		moneylender = [[[Moneylender alloc] init] retain];
	}
	return moneylender;
}

- (Remodel *) remodel {
	if (!remodel) {
		remodel = [[[Remodel alloc] init] retain];
	}
	return remodel;
}

- (Smithy *) smithy {
	if (!smithy) {
		smithy = [[[Smithy alloc] init] retain];
	}
	return smithy;
}

- (ThroneRoom *) throneRoom {
	if (!throneRoom) {
		throneRoom = [[[ThroneRoom alloc] init] retain];
	}
	return throneRoom;
}

- (Village *) village {
	if (!village) {
		village = [[[Village alloc] init] retain];
	}
	return village;
}

- (Woodcutter *) woodcutter {
	if (!woodcutter) {
		woodcutter = [[[Woodcutter alloc] init] retain];
	}
	return woodcutter;
}

- (Workshop *) workshop {
	if (!workshop) {
		workshop = [[[Workshop alloc] init] retain];
	}
	return workshop;
}

# pragma mark -
# pragma mark Implementation

- (Card *) getCardForIndex: (NSUInteger) index {
	switch (index) {
		case 0:
			return self.cellar;
		case 1:
			return self.chancellor;
		case 2:
			return self.chapel;
		case 3:
			return self.feast;
		case 4:
			return self.gardens;
		case 5:
			return self.moneylender;
		case 6:
			return self.remodel;
		case 7:
			return self.smithy;
		case 8:
			return self.throneRoom;
		case 9:
			return self.village;
		case 10:
			return self.woodcutter;
		case 11:
			return self.workshop;
		default:
			return nil;
	}
}

- (NSMutableArray *) getCards {
	return [NSMutableArray arrayWithObjects:self.cellar, self.chancellor, self.chapel, self.feast, self.gardens, self.moneylender,
			self.remodel, self.smithy, self.throneRoom, self.village, self.woodcutter, self.workshop, nil];
}

- (NSMutableArray *) generateKingdomDecks {
	// choose 10 cards
	NSMutableArray *cards = [self getCards];
	NSMutableArray *selectedCards = [NSMutableArray arrayWithCapacity:10];
	while ([selectedCards count] < 10) {
		int random = arc4random() % [cards count];
		Card *card = [cards objectAtIndex:random];
		[cards removeObjectAtIndex:random];
		[selectedCards addObject:card];
	}
	// now sort
	[selectedCards sortUsingSelector:@selector(compare:)];
	
	NSMutableArray *decks = [NSMutableArray arrayWithCapacity:10];
	for (Card *card in selectedCards) {
		HomogenousDeck *deck = [[HomogenousDeck alloc] initWithCard:card AndNumber:10];
		[decks addObject:deck];
		[deck release];
	}
	return decks;
}

@end
