//
//  ItemViewController.h
//  Homepwner
//
//  Created by Ken Hui on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StationDetailsController;

@interface StationsController : UITableViewController {
	NSMutableArray *stations;
	StationDetailsController *detailViewController;
}

@end
