//
//  KingdomCards.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cellar.h"
#import "Chancellor.h"
#import "Chapel.h"
#import "Feast.h"
#import "Gardens.h"
#import "Moneylender.h"
#import "Remodel.h"
#import "Smithy.h"
#import "ThroneRoom.h"
#import "Village.h"
#import "Woodcutter.h"
#import "Workshop.h"


@interface KingdomCards : NSObject {
	Cellar *cellar;
	Chancellor *chancellor;
	Chapel *chapel;
	Feast *feast;
	Gardens *gardens;
	Moneylender *moneylender;
	Remodel *remodel;
	Smithy *smithy;
	ThroneRoom *throneRoom;
	Village *village;
	Woodcutter *woodcutter;
	Workshop *workshop;
}

@property (readonly) Cellar *cellar;
@property (readonly) Chancellor *chancellor;
@property (readonly) Chapel *chapel;
@property (readonly) Feast *feast;
@property (readonly) Gardens *gardens;
@property (readonly) Moneylender *moneylender;
@property (readonly) Remodel *remodel;
@property (readonly) Smithy *smithy;
@property (readonly) ThroneRoom *throneRoom;
@property (readonly) Village *village;
@property (readonly) Woodcutter *woodcutter;
@property (readonly) Workshop *workshop;

+ (KingdomCards *) sharedInstance;

- (NSMutableArray *) generateKingdomDecks;

@end
