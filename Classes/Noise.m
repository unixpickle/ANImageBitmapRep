//
//  Noise.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Noise.h"


@implementation Noise

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
	self.title = @"Noise";
	CGSize sz = [noiseView frame].size;
	ANImageBitmapRep * irep = [[ANImageBitmapRep alloc] initWithSize:sz];
	for (int y = 0; y < sz.height; y++) {
		for (int x = 0; x < sz.width; x++) {
			// here we will stab a monkey,
			// then drain its guts on the floor.
			CGFloat random[4];
			random[0] = ((CGFloat)(arc4random() % 20) + 90.0f) / 255.0f;
			random[1] = random[0];
			random[2] = random[0];
			random[3] = 1;
			[irep setPixel:random atX:x y:y];
		}
	}
	[noiseView setImage:[irep image]];
	[irep release];
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


- (void)dealloc {
    [super dealloc];
}


@end
