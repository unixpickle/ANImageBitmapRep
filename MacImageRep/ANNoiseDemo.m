//
//  ANNoiseDemo.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANNoiseDemo.h"

@implementation ANNoiseDemo

+ (NSString *)demoDisplayName {
	return @"Noise";
}

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	if (!blurImage) {
		BMPoint size = BMPointMake(self.frame.size.width, self.frame.size.height);
		ANImageBitmapRep * image = [[ANImageBitmapRep alloc] initWithSize:size];
		for (int x = 0; x < size.x; x++) {
			for (int y = 0; y < size.y; y++) {
				CGFloat brigthness = 0.7 + ((CGFloat)(arc4random() % 100) / 2500.0f);
				[image setPixel:BMPixelMake(brigthness, brigthness, brigthness, 1)
						atPoint:BMPointMake(x, y)];
			}
		}
		blurImage = [image image];
	}
	[blurImage drawAtPoint:NSMakePoint(0, 0) fromRect:NSZeroRect
				 operation:NSCompositeSourceOver fraction:1];
}

@end
