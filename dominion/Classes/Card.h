//
//  Card.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Game;

typedef enum {
	Action,
	ActionReaction,
	ActionAttack,
	Victory,
	Treasure
} CardType;

@interface Card : NSObject {
}

@property (readonly) NSString *name;
@property (readonly) NSString *description;
@property (readonly) CardType cardType;
@property (readonly) NSUInteger cost;
@property (readonly) NSUInteger coins;
@property (readonly) Boolean isAction;
@property (readonly) Boolean isTreasure;

- (NSUInteger) victoryPointsInGame: (Game *) game;

@end
