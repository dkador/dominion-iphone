//
//  TreasureCards.h
//  dominion
//
//  Created by Daniel Kador on 11/29/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Copper.h"
#import "Silver.h"
#import "Gold.h"


typedef enum {
	CopperType,
	SilverType,
	GoldType
} TreasureCardTypes;

@interface TreasureCards : NSObject {
	Copper *copper;
	Silver *silver;
	Gold *gold;
}

@property (readonly) Copper *copper;
@property (readonly) Silver *silver;
@property (readonly) Gold *gold;

+ (TreasureCards *) sharedInstance;

@end
