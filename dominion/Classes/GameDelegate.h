//
//  GameDelegate.h
//  dominion
//
//  Created by Daniel Kador on 12/1/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Game;
@class Card;

@protocol GameDelegate

@optional

- (void) discardFinished: (NSUInteger) numCardsDiscarded InGame: (Game *) game;
- (void) cardsTrashed: (NSArray *) cards InGame: (Game *) game;
- (void) actionCardSelected: (Card *) card InGame: (Game *) game;
- (void) cardGained;

@end
