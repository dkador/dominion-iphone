//
//  KingdomCards.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Adventurer.h"
#import "Cellar.h"
#import "Chancellor.h"
#import "Chapel.h"
#import "CouncilRoom.h"
#import "Feast.h"
#import "Festival.h"
#import "Gardens.h"
#import "Laboratory.h"
#import "Library.h"
#import "Market.h"
#import "Mine.h"
#import "Moat.h"
#import "Moneylender.h"
#import "Remodel.h"
#import "Smithy.h"
#import "ThroneRoom.h"
#import "Village.h"
#import "Witch.h"
#import "Woodcutter.h"
#import "Workshop.h"


@interface KingdomCards : NSObject {
	Adventurer *adventurer;
	Cellar *cellar;
	Chancellor *chancellor;
	Chapel *chapel;
	CouncilRoom *councilRoom;
	Feast *feast;
	Festival *festival;
	Gardens *gardens;
	Laboratory *laboratory;
	Library *library;
	Market *market;
	Mine *mine;
	Moat *moat;
	Moneylender *moneylender;
	Remodel *remodel;
	Smithy *smithy;
	ThroneRoom *throneRoom;
	Village *village;
	Witch *witch;
	Woodcutter *woodcutter;
	Workshop *workshop;
}

@property (readonly) Adventurer *adventurer;
@property (readonly) Cellar *cellar;
@property (readonly) Chancellor *chancellor;
@property (readonly) Chapel *chapel;
@property (readonly) CouncilRoom *councilRoom;
@property (readonly) Feast *feast;
@property (readonly) Festival *festival;
@property (readonly) Gardens *gardens;
@property (readonly) Laboratory *laboratory;
@property (readonly) Library *library;
@property (readonly) Market *market;
@property (readonly) Mine *mine;
@property (readonly) Moat *moat;
@property (readonly) Moneylender *moneylender;
@property (readonly) Remodel *remodel;
@property (readonly) Smithy *smithy;
@property (readonly) ThroneRoom *throneRoom;
@property (readonly) Village *village;
@property (readonly) Witch *witch;
@property (readonly) Woodcutter *woodcutter;
@property (readonly) Workshop *workshop;

+ (KingdomCards *) sharedInstance;

- (NSMutableArray *) generateKingdomDecks;

@end
