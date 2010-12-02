//
//  dominionViewController.m
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import "dominionViewController.h"
#import "VictoryCards.h"
#import "TreasureCards.h"

@implementation dominionViewController

@synthesize game;

@synthesize kingdom1Button;
@synthesize kingdom2Button;
@synthesize kingdom3Button;
@synthesize kingdom4Button;
@synthesize kingdom5Button;
@synthesize kingdom6Button;
@synthesize kingdom7Button;
@synthesize kingdom8Button;
@synthesize kingdom9Button;
@synthesize kingdom10Button;

@synthesize copperButton, silverButton, goldButton;
@synthesize estateButton, duchyButton, provinceButton, curseButton, trashButton;

@synthesize hand1Button;
@synthesize hand2Button;
@synthesize hand3Button;
@synthesize hand4Button;
@synthesize hand5Button;
@synthesize hand6Button;
@synthesize hand7Button;
@synthesize hand8Button;
@synthesize hand9Button;
@synthesize hand10Button;

@synthesize deckButton, discardButton;

@synthesize newGameButton, actionButton, buyButton, cleanupButton;

@synthesize textView, textDetails, nextButton;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

# pragma mark -
# pragma mark Implementation

- (IBAction) kingdom1ButtonSelected {
	[self.game buyKingdomCardAtIndex:0];
}

- (IBAction) kingdom2ButtonSelected {
	[self.game buyKingdomCardAtIndex:1];
}

- (IBAction) kingdom3ButtonSelected {
	[self.game buyKingdomCardAtIndex:2];
}

- (IBAction) kingdom4ButtonSelected {
	[self.game buyKingdomCardAtIndex:3];
}

- (IBAction) kingdom5ButtonSelected {
	[self.game buyKingdomCardAtIndex:4];
}

- (IBAction) kingdom6ButtonSelected {
	[self.game buyKingdomCardAtIndex:5];
}

- (IBAction) kingdom7ButtonSelected {
	[self.game buyKingdomCardAtIndex:6];
}

- (IBAction) kingdom8ButtonSelected {
	[self.game buyKingdomCardAtIndex:7];
}

- (IBAction) kingdom9ButtonSelected {
	[self.game buyKingdomCardAtIndex:8];
}

- (IBAction) kingdom10ButtonSelected {
	[self.game buyKingdomCardAtIndex:9];
}

- (IBAction) estateButtonSelected {
	[self.game buyVictoryCard:EstateType];
}

- (IBAction) duchyButtonSelected {
	[self.game buyVictoryCard:DuchyType];	
}

- (IBAction) provinceButtonSelected {
	[self.game buyVictoryCard:ProvinceType];	
}

- (IBAction) curseButtonSelected {
	
}

- (IBAction) copperButtonSelected {
	[self.game buyTreasureCard:CopperType];
}

- (IBAction) silverButtonSelected {
	[self.game buyTreasureCard:SilverType];	
}

- (IBAction) goldButtonSelected {
	[self.game buyTreasureCard:GoldType];	
}

- (IBAction) hand1ButtonSelected {
	[self.game cardInHandSelectedAtIndex:0];
}

- (IBAction) hand2ButtonSelected {
	[self.game cardInHandSelectedAtIndex:1];
}

- (IBAction) hand3ButtonSelected {
	[self.game cardInHandSelectedAtIndex:2];
}

- (IBAction) hand4ButtonSelected {
	[self.game cardInHandSelectedAtIndex:3];
}

- (IBAction) hand5ButtonSelected {
	[self.game cardInHandSelectedAtIndex:4];
}

- (IBAction) hand6ButtonSelected {
	[self.game cardInHandSelectedAtIndex:5];
}

- (IBAction) hand7ButtonSelected {
	[self.game cardInHandSelectedAtIndex:6];
}

- (IBAction) hand8ButtonSelected {
	[self.game cardInHandSelectedAtIndex:7];
}

- (IBAction) hand9ButtonSelected {
	[self.game cardInHandSelectedAtIndex:8];
}

- (IBAction) hand10ButtonSelected {
	[self.game cardInHandSelectedAtIndex:9];
}

- (IBAction) newGameButtonSelected {
	Game *theGame = [[Game alloc] initWithController:self];
	self.game = theGame;
	[theGame release];
	self.game.controller = self;
	[self.game setupGame];
}

- (IBAction) nextButtonSelected {
	[self.game doneWithCurrentTurnState];
}

- (void)dealloc {
	[self.game release];
    [super dealloc];
}

@end
