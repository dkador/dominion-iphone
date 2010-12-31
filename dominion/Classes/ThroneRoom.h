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


@class Player;

@interface ThroneRoom : ActionCard <ActionDelegate> {
	Player *thePlayer;
	id<GameDelegate> gameDelegate;
	ActionCard *theAction;
	Boolean executedOnce;
	
	NSUInteger currentPlayerIndexToAttack;
	ActionCard *currentAttackCard;
}

@property (nonatomic, retain) Player *thePlayer;
@property (nonatomic, retain) id<GameDelegate> gameDelegate;
@property (nonatomic, retain) ActionCard *theAction;
@property (nonatomic) Boolean executedOnce;

@property (nonatomic) NSUInteger currentPlayerIndexToAttack;
@property (nonatomic, retain) ActionCard *currentAttackCard;

@end
