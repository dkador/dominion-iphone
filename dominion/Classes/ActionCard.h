//
//  ActionCard.h
//  dominion
//
//  Created by Daniel Kador on 11/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"]
#import "ActionDelegate.h"
#import "GameDelegate.h"


@class Game;
@class Player;

@interface ActionCard : Card <GameDelegate> {
	id<ActionDelegate> delegate;
}

@property (nonatomic, retain) id<ActionDelegate> delegate;

- (Boolean) takeAction: (Player *) player;

@end
