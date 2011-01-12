    //
//  NewGameController.m
//  dominion
//
//  Created by Daniel Kador on 1/11/11.
//  Copyright 2011 Dorkfort.com. All rights reserved.
//

#import "NewGameController.h"
#import "NewSinglePlayerGameController.h"


@implementation NewGameController

@synthesize rootTableView, newSinglePlayerGameController;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	// set background
	[self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	
	// create a label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 768 - 20, 100)];
	label.adjustsFontSizeToFitWidth = NO;
	[label setBackgroundColor:[UIColor clearColor]];
	[label setText:@"DOMINION"];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize:100.0];
	[self.view addSubview:label];
	[label release];
	
	// create the table view
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 100, 768 - 20, 500) style:UITableViewStyleGrouped];
	tableView.backgroundColor = [UIColor clearColor];
	tableView.backgroundView = nil;
	tableView.opaque = NO;
	tableView.delegate = self;
	tableView.dataSource = self;
	[self.view addSubview:tableView];
	self.rootTableView = tableView;
	[tableView reloadData];
	[tableView release];

	//TODO give the navbar a background that matches the rest of the app
	self.navigationController.navigationBar.tintColor = [UIColor clearColor];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.rootTableView = nil;
	self.newSinglePlayerGameController = nil;
    [super dealloc];
}

# pragma mark -
# pragma mark UITableViewController implementation

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 3;
	} else {
		return 1;
	}
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"NewGameControllerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.backgroundColor = [UIColor darkGrayColor];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			cell.textLabel.text = @"Single Player";
		} else if (indexPath.row == 1) {
			cell.textLabel.text = @"Resume Game";
			if (self.newSinglePlayerGameController.dominionViewController) {
				cell.textLabel.textColor = [UIColor whiteColor];
			} else {
				cell.textLabel.textColor = [UIColor grayColor];
			}
		} else {
			cell.textLabel.text = @"Multi Player";
			cell.textLabel.textColor = [UIColor grayColor];
		}
	} else {
		cell.textLabel.text = @"How to Play Dominion";
		cell.textLabel.textColor = [UIColor grayColor];
	}

    return cell;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 && indexPath.row == 1 && !self.newSinglePlayerGameController.dominionViewController) {
		return nil;
	}
	return indexPath;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 && indexPath.row == 0) {
		NewSinglePlayerGameController *controller = [[NewSinglePlayerGameController alloc] init];
		controller.newGameController = self;
		self.newSinglePlayerGameController = controller;
		[[self navigationController] pushViewController:controller animated:YES];
		[controller release];
	} else if (indexPath.section == 0 && indexPath.row == 1 && self.newSinglePlayerGameController.dominionViewController) {
		[self.navigationController pushViewController:self.newSinglePlayerGameController.dominionViewController animated:YES];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
