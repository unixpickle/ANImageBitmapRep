//
//  ANInverterDemo.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANInverterDemo.h"

@implementation ANInverterDemo

+ (NSString *)demoDisplayName {
	return @"Color Inverter";
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		invertMe = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 10, frame.size.width, 270)];
		invertButton = [[NSButton alloc] initWithFrame:NSMakeRect(frame.size.width / 2 - 40, 288, 80, 24)];
		[invertButton setTitle:@"Invert"];
		[invertButton setTarget:self];
		[invertButton setAction:@selector(invertColors:)];
		[invertButton setBezelStyle:NSRoundedBezelStyle];
		[self addSubview:invertButton];
		[self addSubview:invertMe];
		// create images
		regular = [NSImage imageNamed:@"inverter.png"];
		ANImageBitmapRep * irep = [ANImageBitmapRep imageBitmapRepWithImage:regular];
		[irep invertColors];
		inverted = [irep image];
		isInverted = YES;
		[self invertColors:nil];
	}
	return self;
}

- (void)invertColors:(id)sender {
	if (isInverted) {
		[invertMe setImage:regular];
		isInverted = NO;
	} else {
		[invertMe setImage:inverted];
		isInverted = YES;
	}
}

@end
