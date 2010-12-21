//
//  Moneylender.h
//  dominion
//
//  Created by Daniel Kador on 12/2/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"


@class Player;

@interface Moneylender : ActionCard <UIAlertViewDelegate> {
	Player *thePlayer;
}

@property (nonatomic, retain) Player *thePlayer;

@end
