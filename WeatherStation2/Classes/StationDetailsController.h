//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by Ken Hui on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Station;

@interface StationDetailsController : UIViewController {
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *serialNumberField;
	IBOutlet UITextField *latitudeField;
	IBOutlet UITextField *longitudeField;
	IBOutlet UILabel *dateLabel;
	
	Station *editingStation;
}

@property (nonatomic, assign) Station *editingStation;

- (void)registerForKeyboardNotifications;

@end
