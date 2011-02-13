//
//  HomepwnerAppDelegate.h
//  Homepwner
//
//  Created by Ken Hui on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StationsController;

@interface AppController : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	StationsController *itemsViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

