//
//  GameDelegate.h
//  dominion
//
//  Created by Daniel Kador on 12/1/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Player;
@class Game;
@class Card;

@protocol GameDelegate

- (NSString *) name;

@optional

- (void) discardFinished: (NSUInteger) numCardsDiscarded ForPlayer: (Player *) player;
- (Boolean) isTrashAllowed: (Card *) card ForPlayer: (Player *) player;
- (void) cardsTrashed: (NSArray *) cards ForPlayer: (Player *) player;
- (void) actionCardSelected: (Card *) card ForPlayer: (Player *) player;
- (Boolean) isGainAllowed: (Card *) card ForPlayer: (Player *) player;
- (void) cardGained: (Card *) card;
- (void) couldNotDrawForPlayer: (Player *) player;

@end
