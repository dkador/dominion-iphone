//
//  HandViewHelper.m
//  dominion
//
//  Created by Daniel Kador on 12/30/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "HandViewHelper.h"
#import "Deck.h"
#import "Card.h"


@implementation HandViewHelper

@synthesize deck, controller, rootView, delegate;

- (id) initWithDeck: (Deck *) theDeck AndController: (UIViewController *) theController {
	if ((self = [super init])) {
		self.deck = theDeck;
		self.controller = theController;
	}
	return self;
}

- (void) displayHandWithMessage: (NSString *) message {
	// figure out # of rows necessary
	// we'll display up to four rows of 4 cards each
	NSUInteger numRows = self.deck.numCardsLeft / 4;
	if (self.deck.numCardsLeft % 4 != 0) {
		numRows++;
	}
	if (numRows == 0) {
		numRows = 1;
	}
	
	CGFloat width = 613;
	CGFloat height = (235 * numRows) + (8 * (numRows - 1));
	height += 100; // for UITextView
	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
	view.backgroundColor = [UIColor blackColor];
	
	UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, height - 100, width, 100)];
	textView.delegate = self;
	textView.layer.cornerRadius = 8;
	textView.text = message;
	[view addSubview:textView];
	
	CGFloat buttonWidth = 147;
	CGFloat buttonHeight = 235;
	for (NSUInteger i=0; i<self.deck.numCardsLeft; i++) {
		// create a new button
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setBackgroundImage:[UIImage imageNamed:[self.deck cardAtIndex:i].imageFileName] forState:UIControlStateNormal];
		
		// make it do something when tapped
		[button addTarget:self action:@selector(cardSelected:) forControlEvents:UIControlEventTouchUpInside];
		button.tag = i;
		
		// position the button in the view correctly
		CGFloat startingX = (i % 4 * buttonWidth) + (i % 4 * 8);
		CGFloat startingY = (i / 4 * buttonHeight) + (i / 4 * 8);
		button.frame = CGRectMake(startingX, startingY, buttonWidth, buttonHeight);
		[view addSubview:button];
	}
		
	self.rootView = view;
	[self.controller.view addSubview:rootView];
}

- (void) hideEverything {
	[self.rootView removeFromSuperview];
}

- (void) cardSelected: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[self.delegate cardSelected:[self.deck cardAtIndex:index]];
}

- (void) dealloc {
	self.deck = nil;
	self.controller = nil;
	self.rootView = nil;
	self.delegate = nil;
	[super dealloc];
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
	[self.delegate cardSelected:nil];
	return NO;
}

@end
