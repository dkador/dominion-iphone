//
//  VictoryCards.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Estate.h"
#import "Duchy.h"
#import "Province.h"
#import "Curse.h"


typedef enum {
	EstateType,
	DuchyType,
	ProvinceType,
	CurseType
} VictoryCardTypes;

@interface VictoryCards : NSObject {
	Estate *estate;
	Duchy *duchy;
	Province *province;
	Curse *curse;
}

@property (readonly) Estate *estate;
@property (readonly) Duchy *duchy;
@property (readonly) Province *province;
@property (readonly) Curse *curse;

+ (VictoryCards *) sharedInstance;

@end
