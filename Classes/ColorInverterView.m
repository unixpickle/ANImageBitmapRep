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
    // Drawing code.
	if (!image) {
#if __has_feature(objc_arc) == 1
		image = [ANImageBitmapRep imageBitmapRepWithImage:[UIImage imageNamed:@"inverter.png"]];
#else
		image = [[ANImageBitmapRep imageBitmapRepWithImage:[UIImage imageNamed:@"inverter.png"]] retain];
#endif
	}
	[(UIImage *)[image image] drawInRect:self.bounds];
}

#if __has_feature(objc_arc) != 1
- (void)dealloc {
	if (image) [image release];
    [super dealloc];
}
#endif

@end
