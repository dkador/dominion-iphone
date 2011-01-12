//
//  NewSinglePlayerGameController.m
//  dominion
//
//  Created by Daniel Kador on 1/11/11.
//  Copyright 2011 Dorkfort.com. All rights reserved.
//

#import "NewSinglePlayerGameController.h"
#import "NewGameController.h"


@implementation NewSinglePlayerGameController

@synthesize rootTableView, numCpuPlayersTableView, newGameController, dominionViewController;
@synthesize numCpuPlayers;

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
	
	self.numCpuPlayers = 1;
	
	// set background
	[self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
	
	// create the table view
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 768-20, 500) style:UITableViewStyleGrouped];
	self.rootTableView = tableView;
	tableView.backgroundColor = [UIColor clearColor];
	tableView.backgroundView = nil;
	tableView.opaque = NO;
	tableView.delegate = self;
	tableView.dataSource = self;
	[self.view addSubview:tableView];
	[tableView reloadData];
	[tableView release];
	
	// set the button to start the game
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(createGame)];
	self.navigationItem.rightBarButtonItem = item;
	[item release];
}

- (void) createGame {
	NSLog(@"creating game");
	dominionViewController *controller = [[dominionViewController alloc] initWithNibName:@"dominionViewController" bundle:nil];
	self.dominionViewController = controller;
	[[self.newGameController rootTableView] reloadData];
	[self.navigationController pushViewController:controller animated:YES];
	[controller newGameButtonSelected:self.numCpuPlayers];
	[controller release];
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
	self.numCpuPlayersTableView = nil;
	self.newGameController = nil;
	self.dominionViewController = nil;
    [super dealloc];
}

# pragma mark -
# pragma mark UITableViewDelegate implementation

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.rootTableView) {
		return 1;
	} else if (tableView == self.numCpuPlayersTableView) {
		return 3;
	} else {
		return 0;
	}
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"NewSinglePlayerGameControllerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
		cell.backgroundColor = [UIColor darkGrayColor];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.detailTextLabel.textColor = [UIColor whiteColor];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
	if (tableView == self.rootTableView) {
		cell.textLabel.text = @"Number of CPU Players";
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.numCpuPlayers];
	} else if (tableView == self.numCpuPlayersTableView) {
		if (indexPath.row+1 == self.numCpuPlayers) {
			//TODO this sucks, I apparently can't change the color of the checkmark. have to use an image, I guess.
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
		cell.detailTextLabel.text = @"";
	}
	
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.rootTableView) {
		UITableViewController *controller = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
		self.numCpuPlayersTableView = controller.tableView;
		controller.tableView.delegate = self;
		controller.tableView.dataSource = self;
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	} else if (tableView == self.numCpuPlayersTableView) {
		NSArray *cellIndexPaths = [tableView indexPathsForVisibleRows];
		for (NSIndexPath *thePath in cellIndexPaths) {
			[[tableView cellForRowAtIndexPath:thePath] setAccessoryType:UITableViewCellAccessoryNone];
		}
		[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
		self.numCpuPlayers = indexPath.row + 1;
		[self.rootTableView reloadData];
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
