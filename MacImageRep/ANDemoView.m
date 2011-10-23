//
//  ANDemoView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANDemoView.h"

@implementation ANDemoView

+ (NSString *)demoDisplayName {
	return @"Untitled";
}

- (BOOL)isFlipped {
	return YES;
}

- (void)drawRect:(NSRect)frame {
	[super drawRect:frame];
	[[NSColor colorWithCalibratedRed:0.9 green:0.92 blue:0.94 alpha:1] set];
	NSRectFill(frame);
}

@end
