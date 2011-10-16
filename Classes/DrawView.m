//
//  DrawView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"


@implementation DrawView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	initial = [[touches anyObject] locationInView:self];
	initial.y = self.frame.size.height - initial.y;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	static CGFloat color[4] = {1, 0.5, 0.5, 1};
	CGPoint points[2];
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	if (!bitmap) {
		bitmap = [ANImageBitmapRep imageBitmapRepWithCGSize:[self frame].size];
	}
	CGPoint p = [[touches anyObject] locationInView:self];
	p.y = self.frame.size.height - p.y;
	points[0] = initial;
	points[1] = p;
	CGContextRef ctx = [bitmap context];
	CGContextSetStrokeColorSpace(ctx, space);
	CGContextSetStrokeColor(ctx, color);
	CGContextSetLineWidth(ctx, 4);
	CGContextSetLineCap(ctx, kCGLineCapRound);
	CGContextStrokeLineSegments(ctx, points, 2);
	initial = p;
	CGColorSpaceRelease(space);
	[bitmap setNeedsUpdate:YES];
	[self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
	if (bitmap) {
		[[bitmap image] drawInRect:self.bounds];
	}
}




@end
