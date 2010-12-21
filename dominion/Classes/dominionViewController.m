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

@synthesize deckButton, discardButton;

@synthesize newGameButton, actionButton, buyButton, cleanupButton;

@synthesize textView, textDetails, nextButton, handButtons;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	// initialize hand buttons array
	self.handButtons = [NSMutableArray array];
	
	// add actions to kingdom buttons
	NSArray *kingdomButtons = [NSArray arrayWithObjects:self.kingdom1Button, self.kingdom2Button, self.kingdom3Button, 
							   self.kingdom4Button, self.kingdom5Button, self.kingdom6Button, self.kingdom7Button, self.kingdom8Button,
							   self.kingdom9Button, self.kingdom10Button, nil];
	NSUInteger index = 0;
	for (UIButton *button in kingdomButtons) {
		[button addTarget:self action:@selector(kingdomButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
		[button addTarget:self action:@selector(kingdomButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
		button.tag = index;
		index++;
	}
	
	// add actions to victory buttons
	index = 0;
	NSArray *victoryButtons = [NSArray arrayWithObjects:self.estateButton, self.duchyButton, self.provinceButton, self.curseButton, nil];
	for (UIButton *button in victoryButtons) {
		[button addTarget:self action:@selector(victoryButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
		[button addTarget:self action:@selector(victoryButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
		button.tag = index;
		index++;
	}
	
	// add actions to treasure buttons
	index = 0;
	NSArray *treasureButtons = [NSArray arrayWithObjects:self.copperButton, self.silverButton, self.goldButton, nil];
	for (UIButton *button in treasureButtons) {
		[button addTarget:self action:@selector(treasureButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
		[button addTarget:self action:@selector(treasureButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
		button.tag = index;
		index++;
	}
}

- (void) setupHandButtons: (NSUInteger) numCardsInHand {
	// clear out old buttons
	UIButton *oldButton;
	while ((oldButton = [self.handButtons lastObject])) {
		[oldButton removeFromSuperview];
		[self.handButtons removeLastObject];
	}
		   
	CGFloat startingX = 660;
	CGFloat startingY = 690;
	CGFloat width = 102;
	CGFloat height = 163;
	for (NSUInteger i=0; i<numCardsInHand; i++) {
		// create a new button
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		// make it do something when tapped
		[button addTarget:self action:@selector(handButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
		[button addTarget:self action:@selector(handButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
		button.tag = i;
		
		// position the button in the view correctly
		button.frame = CGRectMake(startingX - (i >= 8 ? (width + 8) : 0), startingY + ((i % 8) * 20), width, height);
		[self.view addSubview:button];
		[self.handButtons addObject:button];
	}
}

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

- (void) kingdomButtonSelected: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showImage:) object:[[self.game.kingdomDecks objectAtIndex:index] peek].imageFileName];
	if (self.imageView.hidden) {
		[self.game buyKingdomCardAtIndex:index];
	} 
	if (!self.holdDetected) {
		self.imageView.hidden = YES;
	}
	self.holdDetected = NO;
}

- (void) kingdomButtonTouchDown: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[self performSelector:@selector(showImage:) withObject:[[self.game.kingdomDecks objectAtIndex:index] peek].imageFileName afterDelay:.7];
}

@synthesize imageView, holdDetected;

- (void) showImage: (NSString *) imageFileName {
	self.holdDetected = YES;
	self.imageView.image = [UIImage imageNamed:imageFileName];
	self.imageView.hidden = NO;
}

- (void) hideImage {
	self.holdDetected = NO;
	self.imageView.hidden = YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self hideImage];
}

- (NSString *) imageForVictoryButton: (NSUInteger) index {
	NSString *imageFileName;
	if (index == 0) {
		imageFileName = [self.game.estateDeck peek].imageFileName;
	} else if (index == 1) {
		imageFileName = [self.game.duchyDeck peek].imageFileName;
	} else if (index == 2) {
		imageFileName = [self.game.provinceDeck peek].imageFileName;
	} else if (index == 3) {
		imageFileName = [self.game.curseDeck peek].imageFileName;
	}
	return imageFileName;
}

- (void) victoryButtonSelected: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showImage:) object:[self imageForVictoryButton:index]];
	if (self.imageView.hidden) {
		VictoryCardTypes type;
		if (index == 0) {
			type = EstateType;
		} else if (index == 1) {
			type = DuchyType;
		} else if (index == 2) {
			type = ProvinceType;
		} else {
			type = CurseType;
		}
		[self.game buyVictoryCard:type];
	} 
	if (!self.holdDetected) {
		self.imageView.hidden = YES;
	}
	self.holdDetected = NO;
}

- (void) victoryButtonTouchDown: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	NSString *imageFileName = [self imageForVictoryButton:index];
	[self performSelector:@selector(showImage:) withObject:imageFileName afterDelay:.7];	
}

- (NSString *) imageForTreasureButton: (NSUInteger) index {
	NSString *imageFileName;
	if (index == 0) {
		imageFileName = [self.game.copperDeck peek].imageFileName;
	} else if (index == 1) {
		imageFileName = [self.game.silverDeck peek].imageFileName;
	} else if (index == 2) {
		imageFileName = [self.game.goldDeck peek].imageFileName;
	} 
	return imageFileName;
}

- (void) treasureButtonSelected: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showImage:) object:[self imageForTreasureButton:index]];
	if (self.imageView.hidden) {
		TreasureCardTypes type;
		if (index == 0) {
			type = CopperType;
		} else if (index == 1) {
			type = SilverType;
		} else if (index == 2) {
			type = GoldType;
		} 
		[self.game buyTreasureCard:type];
	}
	if (!self.holdDetected) {
		self.imageView.hidden = YES;
	}
	self.holdDetected = NO;
}

- (void) treasureButtonTouchDown: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[self performSelector:@selector(showImage:) withObject:[self imageForTreasureButton:index] afterDelay:.7];	
}

- (NSString *) imageForHandButton: (NSUInteger) index {
	return [self.game.currentPlayer.hand cardAtIndex:index].imageFileName;
}

- (void) handButtonSelected: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(showImage:) object:[self imageForHandButton:index]];
	if (self.imageView.hidden) {
		[self.game cardInHandSelectedAtIndex:index];
	}
	if (!self.holdDetected) {
		self.imageView.hidden = YES;
	}
	self.holdDetected = NO;
}

- (void) handButtonTouchDown: (id) sender {
	NSUInteger index = ((UIControl *) sender).tag;
	[self performSelector:@selector(showImage:) withObject:[self imageForHandButton:index] afterDelay:.7];
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
