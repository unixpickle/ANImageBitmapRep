//
//  GetPixelDemo.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetPixelDemo.h"


@implementation GetPixelDemo

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame image:(ANImageBitmapRep *)theImage {
	if ((self = [super initWithFrame:frame])) {
		image = [theImage retain];
	}
	return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint p = [[touches anyObject] locationInView:self];
	p.x = round(p.x);
	p.y = round(p.y);
	if (p.x < 0 || p.y < 0 || p.x >= self.frame.size.width || p.y >= self.frame.size.height) {
		return;
	}
	// translate to image
	CGSize scale = CGSizeMake(1, 1);
	scale.width = (CGFloat)([image bitmapSize].x) / self.frame.size.width;
	scale.height = (CGFloat)([image bitmapSize].y) / self.frame.size.height;
	p.x *= scale.width;
	p.y *= scale.height;
	BMPoint point = BMPointMake(round(p.x), round(p.y));
	BMPixel pixel = [image getPixelAtPoint:point];
	[delegate pixelDemoGotPixel:pixel];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	[[image image] drawInRect:rect];
}


- (void)dealloc {
	[image release];
    [super dealloc];
}

@end
