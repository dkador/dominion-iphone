//
//  Laboratory.h
//  dominion
//
//  Created by Daniel Kador on 12/9/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionCard.h"


@interface Laboratory : ActionCard {
	NSUInteger numCardsGained;
}

@property (nonatomic) NSUInteger numCardsGained;

@end
