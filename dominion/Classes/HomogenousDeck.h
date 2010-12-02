//
//  HomogenousDeck.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


@interface HomogenousDeck : Deck {
	Card *card;
	NSUInteger count;
}

@property (nonatomic, retain) Card *card;
@property (nonatomic) NSUInteger count;

- (id) initWithCard: (Card *) theCard AndNumber: (NSUInteger ) num;

@end
