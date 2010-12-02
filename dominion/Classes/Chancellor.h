//
//  Chancellor.h
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"


@class Game;

@interface Chancellor : ActionCard <UIAlertViewDelegate> {
	Game *theGame;
}

@property (nonatomic, retain) Game *theGame;

@end
