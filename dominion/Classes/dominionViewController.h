//
//  dominionViewController.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Game.h"
#import "Player.h"
#import "VictoryCards.h"

@interface dominionViewController : UIViewController <UITextViewDelegate> {
	Game *game;
	
	UIButton *kingdom1Button;
	UIButton *kingdom2Button;
	UIButton *kingdom3Button;
	UIButton *kingdom4Button;
	UIButton *kingdom5Button;
	UIButton *kingdom6Button;
	UIButton *kingdom7Button;
	UIButton *kingdom8Button;
	UIButton *kingdom9Button;
	UIButton *kingdom10Button;
	
	UIButton *copperButton;
	UIButton *silverButton;
	UIButton *goldButton;
	
	UIButton *estateButton;
	UIButton *duchyButton;
	UIButton *provinceButton;
	UIButton *curseButton;
	UIButton *trashButton;
	
	UIButton *deckButton;
	UIButton *discardButton;
	
	UIButton *newGameButton;
	UIButton *actionButton;
	UIButton *buyButton;
	UIButton *cleanupButton;
	
	UITextView *textView;
	UITextView *textDetails;
	UIButton *nextButton;
	
	NSMutableArray *handButtons;
	
	Boolean holdCancelled;
	Boolean holdDetected;
	Boolean holdFinished;
	UIImageView *imageView;
}

@property (nonatomic) Boolean holdDetected;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) Game *game;

@property (nonatomic, retain) IBOutlet UIButton *kingdom1Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom2Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom3Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom4Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom5Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom6Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom7Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom8Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom9Button;
@property (nonatomic, retain) IBOutlet UIButton *kingdom10Button;

@property (nonatomic, retain) IBOutlet UIButton *copperButton;
@property (nonatomic, retain) IBOutlet UIButton *silverButton;
@property (nonatomic, retain) IBOutlet UIButton *goldButton;

@property (nonatomic, retain) IBOutlet UIButton *estateButton;
@property (nonatomic, retain) IBOutlet UIButton *duchyButton;
@property (nonatomic, retain) IBOutlet UIButton *provinceButton;
@property (nonatomic, retain) IBOutlet UIButton *curseButton;
@property (nonatomic, retain) IBOutlet UIButton *trashButton;

@property (nonatomic, retain) IBOutlet UIButton *deckButton;
@property (nonatomic, retain) IBOutlet UIButton *discardButton;

@property (nonatomic, retain) IBOutlet UIButton *newGameButton;
@property (nonatomic, retain) IBOutlet UIButton *actionButton;
@property (nonatomic, retain) IBOutlet UIButton *buyButton;
@property (nonatomic, retain) IBOutlet UIButton *cleanupButton;

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UITextView *textDetails;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) NSMutableArray *handButtons;

- (IBAction) newGameButtonSelected;
- (IBAction) nextButtonSelected;

- (void) setupHandButtons: (NSUInteger) numCardsInHand;

@end

