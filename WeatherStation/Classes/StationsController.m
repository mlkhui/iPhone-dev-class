    //
//  ItemViewController.m
//  Homepwner
//
//  Created by Ken Hui on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StationsController.h"
#import "Station.h"
#import "StationDetailsController.h"

@implementation StationsController

-(id)init{
	
	//Call the superclass's designated initializer
	[super initWithStyle:UITableViewStyleGrouped];
	
	//Create an array of 10 random possession objects
	stations = [[NSMutableArray alloc] init];
	[stations addObject:[[Station alloc] initWithStationName:@"Seattle" 
												   code:@"SEA" 
													   latitude:[NSNumber numberWithDouble:145.4]
													  longitude:[NSNumber numberWithDouble:25.4]]];

	[stations addObject:[[Station alloc] initWithStationName:@"San Francisco" 
												   code:@"SFO" 
													   latitude:[NSNumber numberWithDouble:85.22]
													  longitude:[NSNumber numberWithDouble:-35.9]]];
	
	//Set the nav bar to have the pre-fab'ed Edit button when 
	//ItemsViewController is on top of the stack
	[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	
	//Set the title of the nav bar to Homepwner when ItemsViewController
	//is on top of the stack
	[[self navigationItem] setTitle:@"Stations Viewer"];
	
	return self;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
	int numberOfRows = [stations count];
	//if we are editing, we will have one more row than we have possessions
	if([self isEditing]){
		numberOfRows++;
	}
	return numberOfRows;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[self tableView] reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//Check for a reusable cell first, use that if it exists
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	
	if (!cell) {
	//Create an instance of UITableViewCell, with default appearance
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
								reuseIdentifier:@"UITableViewCell"] autorelease];
	}
	
	//If the table view is filling a row with a possession in it, do as normal
	if ([indexPath row] < [stations count]) {
		Station *p = [stations objectAtIndex:[indexPath row]];
		[[cell textLabel] setText:[p description]];
		[cell.detailTextLabel setText:[NSString stringWithFormat:@"latitude:%@ longitude:%@",p.latitude,p.longitude]];
		
	} else { //Otherwise, if we are editing we have one extra row ...
		[[cell textLabel] setText:@"Add New Item..."];
	}
	
	return cell;
	
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
    [super dealloc];
}

- (void)setEditing:(BOOL)flag animated: (BOOL)animated {
	//Always call super implementation of this method, it needs to do work
	[super setEditing:flag animated:animated];
	
	if (flag) {
		//If entering edit mode, we add another row to our table view
		NSIndexPath *indexPath = 
			[NSIndexPath indexPathForRow:[stations count] inSection:0];
		NSArray *paths =[NSArray arrayWithObject:indexPath];
		[[self tableView] insertRowsAtIndexPaths:paths 
								withRowAnimation:UITableViewRowAnimationLeft];
	} else { //If leaving edit mode, we remove last row from table view
		NSIndexPath *indexPath =
		[NSIndexPath indexPathForRow:[stations count] inSection:0];
		NSArray *paths =[NSArray arrayWithObject:indexPath];
		[[self tableView] deleteRowsAtIndexPaths:paths 
								withRowAnimation:UITableViewRowAnimationFade];
	}
	
	
}

/*
 ----------------------- UITableViewDelegate Protocol --------------------------------
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self isEditing] && [indexPath row] == [stations count]) {
		return UITableViewCellEditingStyleInsert;
	}
	//All other rows remain deletable
	return UITableViewCellEditingStyleDelete;
}

- (NSIndexPath *)tableView:(UITableView *)tableView 
targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath 
	   toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
	
	if ([proposedDestinationIndexPath row] < [stations count]) {
		return proposedDestinationIndexPath;
	}
	
	NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[stations count] - 1 inSection:0];
	
	return betterIndexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Do I need to create the instance of ItemDetailViewController?
	if (!detailViewController) {
		detailViewController = [[StationDetailsController alloc] init];
	}
	
	[detailViewController setEditingStation:
		[stations objectAtIndex:[indexPath row]]];
	
	//Push it onto the top of the navigation controller's stact
	[[self navigationController] pushViewController:detailViewController animated:YES];
	
}


/*
 ----------------------- UITableViewDataSource Protocol --------------------------------
 */
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	//If the table view is asking to commit a delete command
	if (editingStyle== UITableViewCellEditingStyleDelete) {

		//We remove the row being deleted from the possessions array
		[stations removeObjectAtIndex:[indexPath row]];
		
		//WE also remove that row from the table view with an animation
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						 withRowAnimation:UITableViewRowAnimationFade];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
		//If the editing style of the row was insertion,
		//we add a new posession object and new row to the table view
		[stations addObject:[Station randomStation]];
		[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						 withRowAnimation:UITableViewRowAnimationLeft];
	}
}

- (void)tableView:(UITableView *)tableView 
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
	  toIndexPath:(NSIndexPath *)toIndexPath {
	//Get pointer to object being moved
	Station *p = [stations objectAtIndex:[fromIndexPath row]]; //retain count of p is now 1
	
	//Retain p so that it is not dellocated when it's remove from the array
	[p retain]; //retain count of p is now 2
	
	//Remove p from our array, it is automatically sent release
	[stations removeObjectAtIndex:[fromIndexPath row]]; //retain count of p is now 1
	
	//Re-insert p into array at new location, it is automatically retained
	[stations insertObject:p atIndex:[toIndexPath row]]; //retain count of p is now 2
	
	//Release p
	[p release];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	//Only allow rows showing possessions to move
	if ([indexPath row] < [stations count]) {
		return YES;
	}
	return NO;
}


@end
