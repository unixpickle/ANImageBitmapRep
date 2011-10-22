//
//  BlurView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlurView.h"


@implementation BlurView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code.
    }
    return self;
}

- (void)setBlur:(float)_blur {
	blur = _blur;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code.
	if (!image) {
		image = [[ANImageBitmapRep alloc] initWithImage:[UIImage imageNamed:@"starrynight.png"]];
	}
	ANImageBitmapRep * blurred = [[ANImageBitmapRep alloc] initWithImage:[image image]];
	[blurred setQuality:(1 - blur)];
	[[blurred image] drawInRect:self.bounds];
#if __has_feature(objc_arc) != 1	
	[blurred release];
#endif
}

#if __has_feature(objc_arc) != 1
- (void)dealloc {
    [image release];
	[super dealloc];
}
#endif

@end
