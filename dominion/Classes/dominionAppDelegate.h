//
//  dominionAppDelegate.h
//  dominion
//
//  Created by Daniel Kador on 11/28/10.
//  Copyright 2010 Dorkfort.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dominionViewController;
@class NewGameController;

@interface dominionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    //dominionViewController *viewController;
	NewGameController *viewController;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
//@property (nonatomic, retain) IBOutlet dominionViewController *viewController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet NewGameController *viewController;

@end

