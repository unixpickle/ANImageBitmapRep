//
//  GetPixel.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetPixel.h"


@implementation GetPixel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

#if __has_feature(objc_arc) != 1
- (void)dealloc {
    [demoView release];
    [pxlView release];
    [super dealloc];
}
#endif

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * theImage = [UIImage imageNamed:@"wheel.png"];
    demoView = [[GetPixelDemo alloc] initWithFrame:CGRectMake(10, 100, 300, 300) image:[ANImageBitmapRep imageBitmapRepWithImage:theImage]];
    pxlView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 80)];
    [pxlView setBackgroundColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:demoView];
    [self.view addSubview:pxlView];
    [demoView setDelegate:self];
    [self setTitle:@"Get Pixel"];
}

- (void)pixelDemoGotPixel:(BMPixel)pixel {
#if __has_feature(objc_arc) == 1
    @autoreleasepool {
#else
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
#endif
    UIColor * color = UIColorFromBMPixel(pixel);
    [pxlView setBackgroundColor:color];
#if __has_feature(objc_arc) == 1
    }
#else
    [pool drain];
#endif
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
