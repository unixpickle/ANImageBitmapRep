//
//  Rotation.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Rotation.h"
#import "ANImageBitmapRep+Rotate.h"

@implementation Rotation

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self setTitle:@"Rotation"];
	rotateMe = [[ANImageBitmapRep alloc] initWithImage:[UIImage imageNamed:@"rotate_me.png"]];
}


- (IBAction)rotation:(id)sender {
	@autoreleasepool {
		UIImage * rotated = [[UIImage alloc] initWithCGImage:[rotateMe imageByRotating:[angle value]]];
		[rotatedImage setImage:rotated];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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




@end
