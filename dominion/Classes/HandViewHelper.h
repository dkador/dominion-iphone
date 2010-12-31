//
//  HandViewHelper.h
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@class Deck;
@class Card;

@protocol HandViewHelperDelegate

- (void) cardSelected: (Card *) card;

@end


@interface HandViewHelper : NSObject <UITextViewDelegate> {
	UIViewController *controller;
	Deck *deck;
	UIView *rootView;
	id<HandViewHelperDelegate> delegate;
}

@property (nonatomic, retain) UIViewController *controller;
@property (nonatomic, retain) Deck *deck;
@property (nonatomic, retain) UIView *rootView;
@property (nonatomic, retain) id<HandViewHelperDelegate> delegate;

- (id) initWithDeck: (Deck *) theDeck AndController: (UIViewController *) theController;
- (void) displayHandWithMessage: (NSString *) message;
- (void) hideEverything;

@end
