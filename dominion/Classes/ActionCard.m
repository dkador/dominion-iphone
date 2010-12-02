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

- (Boolean) takeAction: (Game *) game {
	[NSException raise:@"Not implemented" format:@""];
	return NO;
}

- (void) dealloc {
	[super dealloc];
}

@end
