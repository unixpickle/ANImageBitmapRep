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
    // Drawing code.
	if (!image) {
		image = [[ANImageBitmapRep imageBitmapRepNamed:@"starrynight.png"] retain];
	}
	ANImageBitmapRep * blurred = [[ANImageBitmapRep alloc] initWithImage:[image image]];
	[blurred setQuality:(1 - blur)];
	[blurred drawInRect:self.bounds];
	[blurred release];
}


- (void)dealloc {
    [image release];
	[super dealloc];
}


@end
