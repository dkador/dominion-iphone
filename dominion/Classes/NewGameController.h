//
//  NewGameController.h
//  dominion
//
//  Created by Daniel Kador on 1/11/11.
//  Copyright 2011 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class NewSinglePlayerGameController;

@interface NewGameController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *rootTableView;
	NewSinglePlayerGameController *newSinglePlayerGameController;
}

@property (nonatomic, retain) UITableView *rootTableView;
@property (nonatomic, retain) NewSinglePlayerGameController *newSinglePlayerGameController;

@end
