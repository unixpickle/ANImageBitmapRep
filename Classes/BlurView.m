//
//  BlurView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlurView.h"
#import "ANImageBitmapRep+Scale.h"

@implementation BlurView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)setBlur:(float)_blur {
	blur = _blur;
	[self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   [self updateImage];
}

- (void)updateImage{
   // Drawing code.
   NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	if (!image) {
		image = [[ANImageBitmapRep alloc] initWithImage:[UIImage imageNamed:@"starrynight.png"]];
	}
	ANImageBitmapRep * blurred = [[ANImageBitmapRep alloc] initWithImage:[image image]];
	[blurred setQuality:(1 - blur)];
	[[blurred image] drawInRect:self.bounds];
	[blurred release];
   [pool drain];
}

/**
 * This method blurs the image to different blur settings to test the preformance
 * @return NSTimeInterval required to compleate tests
 */
- (NSTimeInterval)preformanceTest{
   int stepsCount = 85; //Number of iterations to perform.
   
   NSDate *start = [NSDate date]; //Start Time

   for (int i = 0; i<stepsCount; i++) {
      [self setBlur:0.9*(float)i/stepsCount];
      [self updateImage];
   }
   return -[start timeIntervalSinceNow];
}

- (void)dealloc {
    [image release];
	[super dealloc];
}


@end
