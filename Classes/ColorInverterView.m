//
//  ColorInverterView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ColorInverterView.h"


@implementation ColorInverterView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (IBAction)invert:(id)sender {
	[image invertColors];
	[self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	if (!image) {
		image = [[ANImageBitmapRep imageBitmapRepWithImage:[UIImage imageNamed:@"inverter.png"]] retain];
	}
	[(UIImage *)[image image] drawInRect:self.bounds];
}

/**
 * This method blurs the image to different blur settings to test the preformance
 * @return NSTimeInterval required to compleate tests
 */
- (NSTimeInterval)preformanceTest{
   int stepsCount = 100; //Number of iterations to perform.
   
   NSDate *start = [NSDate date]; //Start Time
   
   for (int i = 0; i<stepsCount; i++) {
      [image invertColors];
   }
   return -[start timeIntervalSinceNow];
}


- (void)dealloc {
	if (image) [image release];
    [super dealloc];
}


@end
