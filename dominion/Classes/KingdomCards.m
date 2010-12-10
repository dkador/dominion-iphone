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

- (Adventurer *) adventurer {
	if (!adventurer) {
		adventurer = [[[Adventurer alloc] init] retain];
	}
	return adventurer;
}

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

- (CouncilRoom *) councilRoom {
	if (!councilRoom) {
		councilRoom = [[[CouncilRoom alloc] init] retain];
	}
	return councilRoom;
}

- (Feast *) feast {
	if (!feast) {
		feast = [[[Feast alloc] init] retain];
	}
	return feast;
}

- (Festival *) festival {
	if (!festival) {
		festival = [[[Festival alloc] init] retain];
	}
	return festival;
}

- (Gardens *) gardens {
	if (!gardens) {
		gardens = [[[Gardens alloc] init] retain];
	}
	return gardens;
}

- (Laboratory *) laboratory {
	if (!laboratory) {
		laboratory = [[[Laboratory alloc] init] retain];
	}
	return laboratory;
}

- (Library *) library {
	if (!library) {
		library = [[[Library alloc] init] retain];
	}
	return library;
}

- (Market *) market {
	if (!market) {
		market = [[[Market alloc] init] retain];
	}
	return market;
}

- (Mine *) mine {
	if (!mine) {
		mine = [[[Mine alloc] init] retain];
	}
	return mine;
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

- (NSMutableArray *) getCards {
	return [NSMutableArray arrayWithObjects:self.adventurer, self.cellar, self.chancellor, self.chapel, self.councilRoom, self.feast, self.festival, 
			self.gardens, self.market, self.mine, self.laboratory, self.library, self.moneylender, self.remodel, self.smithy, self.throneRoom, 
			self.village, self.woodcutter, self.workshop, nil];
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
