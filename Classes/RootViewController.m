//
//  RootViewController.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	views = [[NSArray arrayWithObjects:NSStringFromClass([ColorInverter class]),
			  NSStringFromClass([Blur class]),
			  NSStringFromClass([Noise class]), 
			  NSStringFromClass([Draw class]),
			  NSStringFromClass([Rotation class]), nil] retain];
	self.title = @"Demos";
	
	UIImage * balloon = [UIImage imageNamed:@"Balloon_2@2x-1.png"];
	ANImageBitmapRep * rep = [balloon imageBitmapRep];
	for (int y = 0; y < rep.size.height; y++) {
		for (int x = 0; x < rep.size.width; x++) {
			CGFloat color[4];
			[rep getPixel:color atX:x y:y];
			// replace 230.0f with 255.0f for darker.
			// red tint
			color[0] *= 0.2;
			// green tint
			color[1] *= 0.9;
			// blue tint
			color[2] *= 0.2;
			[rep setPixel:color atX:x y:y];
		}
	}
	NSString * path = [NSString stringWithFormat:@"%@/Documents/test.png", NSHomeDirectory()];
	[UIImagePNGRepresentation([rep image]) writeToFile:path
											atomically:YES];
	NSLog(@"%@", path);
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tv heightForRowAtIndexPath:(NSIndexPath *)p {
	return 80;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [views count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = [views objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
	
	// Configure the cell.

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController * vc = [[NSClassFromString([views objectAtIndex:indexPath.row]) alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[views release];
    [super dealloc];
}


@end

