//
//  ActionCard.m
//  dominion
//
//  Created by Daniel Kador on 11/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "ActionCard.h"
#import "Game.h"


@implementation ActionCard

@synthesize delegate;

- (Boolean) takeAction: (Player *) player {
	[NSException raise:@"Not implemented" format:@""];
	return NO;
}

- (void) dealloc {
	self.delegate = nil;
	[super dealloc];
}

# pragma mark -
# pragma mark GameDelegate implementation

- (Boolean) isTrashAllowed:(Card *)card ForPlayer:(Player *)player {
	return YES;
}

- (void) couldNotDrawForPlayer:(Player *)player {
	// no-op usually
}

@end
