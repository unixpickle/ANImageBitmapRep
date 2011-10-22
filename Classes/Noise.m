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
	BMPoint noiseSize = BMPointFromSize([noiseView frame].size);
	ANImageBitmapRep * irep = [[ANImageBitmapRep alloc] initWithSize:noiseSize];
	for (int y = 0; y < noiseSize.y; y++) {
		for (int x = 0; x < noiseSize.x; x++) {
			CGFloat value = ((CGFloat)(arc4random() % 20) + 90.0f) / 255.0f;
			[irep setPixel:BMPixelMake(value, value, value, 1) atPoint:BMPointMake(x, y)];
		}
	}
	[noiseView setImage:[irep image]];
#if __has_feature(objc_arc) != 1
	[irep release];
#endif
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

#if __has_feature(objc_arc) != 1
- (void)dealloc {
    [super dealloc];
}
#endif

@end
