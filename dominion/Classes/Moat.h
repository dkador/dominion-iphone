//
//  Moat.h
//  dominion
//
//  Created by Daniel Kador on 12/23/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"


@interface Moat : ActionCard {
	NSUInteger numCardsGained;
}

@property (nonatomic) NSUInteger numCardsGained;

@end
