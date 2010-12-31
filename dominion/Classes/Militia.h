//
//  Militia.h
//  dominion
//
//  Created by Daniel Kador on 12/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"
#import "HandViewHelper.h"


@class Player;

@interface Militia : ActionCard <HandViewHelperDelegate> {
	Player *thePlayer;
	HandViewHelper *helper;
}

@property (nonatomic, retain) Player *thePlayer;
@property (nonatomic, retain) HandViewHelper *helper;

@end
