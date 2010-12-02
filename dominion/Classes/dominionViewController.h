//
//  dominionViewController.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface dominionViewController : UIViewController {
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
	
	UIButton *hand1Button;
	UIButton *hand2Button;
	UIButton *hand3Button;
	UIButton *hand4Button;
	UIButton *hand5Button;
	UIButton *hand6Button;
	UIButton *hand7Button;
	UIButton *hand8Button;
	UIButton *hand9Button;
	UIButton *hand10Button;
	
	UIButton *deckButton;
	UIButton *discardButton;
	
	UIButton *newGameButton;
	UIButton *actionButton;
	UIButton *buyButton;
	UIButton *cleanupButton;
	
	UITextView *textView;
	UIButton *nextButton;
}

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

@property (nonatomic, retain) IBOutlet UIButton *hand1Button;
@property (nonatomic, retain) IBOutlet UIButton *hand2Button;
@property (nonatomic, retain) IBOutlet UIButton *hand3Button;
@property (nonatomic, retain) IBOutlet UIButton *hand4Button;
@property (nonatomic, retain) IBOutlet UIButton *hand5Button;
@property (nonatomic, retain) IBOutlet UIButton *hand6Button;
@property (nonatomic, retain) IBOutlet UIButton *hand7Button;
@property (nonatomic, retain) IBOutlet UIButton *hand8Button;
@property (nonatomic, retain) IBOutlet UIButton *hand9Button;
@property (nonatomic, retain) IBOutlet UIButton *hand10Button;

@property (nonatomic, retain) IBOutlet UIButton *deckButton;
@property (nonatomic, retain) IBOutlet UIButton *discardButton;

@property (nonatomic, retain) IBOutlet UIButton *newGameButton;
@property (nonatomic, retain) IBOutlet UIButton *actionButton;
@property (nonatomic, retain) IBOutlet UIButton *buyButton;
@property (nonatomic, retain) IBOutlet UIButton *cleanupButton;

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;

- (IBAction) kingdom1ButtonSelected;
- (IBAction) kingdom2ButtonSelected;
- (IBAction) kingdom3ButtonSelected;
- (IBAction) kingdom4ButtonSelected;
- (IBAction) kingdom5ButtonSelected;
- (IBAction) kingdom6ButtonSelected;
- (IBAction) kingdom7ButtonSelected;
- (IBAction) kingdom8ButtonSelected;
- (IBAction) kingdom9ButtonSelected;
- (IBAction) kingdom10ButtonSelected;

- (IBAction) estateButtonSelected;
- (IBAction) duchyButtonSelected;
- (IBAction) provinceButtonSelected;
- (IBAction) curseButtonSelected;

- (IBAction) copperButtonSelected;
- (IBAction) silverButtonSelected;
- (IBAction) goldButtonSelected;

- (IBAction) hand1ButtonSelected;
- (IBAction) hand2ButtonSelected;
- (IBAction) hand3ButtonSelected;
- (IBAction) hand4ButtonSelected;
- (IBAction) hand5ButtonSelected;
- (IBAction) hand6ButtonSelected;
- (IBAction) hand7ButtonSelected;
- (IBAction) hand8ButtonSelected;
- (IBAction) hand9ButtonSelected;
- (IBAction) hand10ButtonSelected;

- (IBAction) newGameButtonSelected;
- (IBAction) nextButtonSelected;

@end

