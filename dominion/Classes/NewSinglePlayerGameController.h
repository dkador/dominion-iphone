//
//  NewSinglePlayerGameController.h
//  dominion
//
//  Created by Daniel Kador on 1/11/11.
//  Copyright 2011 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dominionViewController.h"


@class NewGameController;

@interface NewSinglePlayerGameController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *rootTableView;
	UITableView *numCpuPlayersTableView;
	NewGameController *newGameController;
	dominionViewController *dominionViewController;
	
	NSUInteger numCpuPlayers;
}

@property (nonatomic, retain) UITableView *rootTableView;
@property (nonatomic, retain) UITableView *numCpuPlayersTableView;
@property (nonatomic, retain) NewGameController *newGameController;
@property (nonatomic, retain) dominionViewController *dominionViewController;

@property (nonatomic) NSUInteger numCpuPlayers;

@end
