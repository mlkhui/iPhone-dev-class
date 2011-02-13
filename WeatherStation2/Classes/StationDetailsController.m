//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by Ken Hui on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StationDetailsController.h"
#import "Station.h"

@implementation StationDetailsController
@synthesize editingStation;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];

	[[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	
	[nameField release];
	nameField = nil;
	
	[serialNumberField release];
	serialNumberField = nil;
	
	[dateLabel release];
	dateLabel = nil;
	
	[longitudeField release];
	longitudeField = nil;
	
	[latitudeField release];
	latitudeField = nil; 
}


- (void)dealloc {
	[nameField release];
	[serialNumberField release];
	[dateLabel release];
	[latitudeField release];
	[longitudeField release];
    [super dealloc];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self registerForKeyboardNotifications];
	
	[nameField setText:[editingStation stationName]];
	[serialNumberField setText:[editingStation stationCode]];

	
	[latitudeField setText:[NSString stringWithFormat:@"%@", editingStation.latitude]];
	[longitudeField setText:[NSString stringWithFormat:@"%@", editingStation.longitude]];
	
	//Create a NSDateFormatter that will turn a date into a simple date string
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	//Use filtered NSDate object to set dateLabel contents
	[dateLabel setText:
	 [dateFormatter stringFromDate:[editingStation dateCreated]]];
	 
	//Change the navigation item to display name of possession
	 [[self navigationItem] setTitle:[editingStation stationName]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	//Clear first responder
	[nameField resignFirstResponder];
	[serialNumberField resignFirstResponder];
	[latitudeField resignFirstResponder];
	[longitudeField resignFirstResponder];
	
	//"Save" changes to editingPossession
	[editingStation setStationName:[nameField text]];
	[editingStation setStationCode:[serialNumberField text]];
	[editingStation setLatitude:[NSNumber numberWithInt:[[latitudeField text] floatValue]]];
	[editingStation setLongitude:[NSNumber numberWithInt:[[longitudeField text] floatValue]]]; 
}

- (void)registerForKeyboardNotifications{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//	
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
//        [scrollView setContentOffset:scrollPoint animated:YES];
//    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
	
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
	
}


@end
