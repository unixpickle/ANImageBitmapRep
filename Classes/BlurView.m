//
//  BlurView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlurView.h"
#import "ScalableBitmapRep.h"

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
		image = [[ANImageBitmapRep alloc] initWithImage:[UIImage imageNamed:@"starrynight.png"]];
	}
	ANImageBitmapRep * blurred = [[ANImageBitmapRep alloc] initWithImage:[image image]];
	[blurred setQuality:(1 - blur)];
	[[blurred image] drawInRect:self.bounds];
	[blurred release];
}


- (void)dealloc {
    [image release];
	[super dealloc];
}


@end
