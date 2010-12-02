//
//  ThroneRoom.h
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"
#import "ActionDelegate.h"
#import "GameDelegate.h"


@class Game;

@interface ThroneRoom : ActionCard <ActionDelegate> {
	Game *theGame;
	id<GameDelegate> gameDelegate;
	ActionCard *theAction;
	Boolean executedOnce;
}

@property (nonatomic, retain) Game *theGame;
@property (nonatomic, retain) id<GameDelegate> gameDelegate;
@property (nonatomic, retain) ActionCard *theAction;
@property (nonatomic) Boolean executedOnce;

@end
