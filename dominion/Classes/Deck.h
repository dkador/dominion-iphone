//
//  Deck.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject {
	NSMutableArray *cards;
	NSString *name;
}

@property (retain) NSMutableArray *cards;
@property (retain) NSString *name;

@property (readonly) NSInteger numCardsLeft;

- (void) shuffle;
- (Card *) draw;
- (Card *) peek;
- (Card *) cardAtIndex: (NSUInteger) index;
- (Card *) removeCardAtIndex: (NSUInteger) index;
- (void) addCard: (Card *) card;
- (void) sort;

@end
