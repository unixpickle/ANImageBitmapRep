//
//  ANInverterDemo.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANDemoView.h"
#import "ANImageBitmapRep.h"

@interface ANInverterDemo : ANDemoView {
	NSImageView * invertMe;
	NSImage * inverted;
	NSImage * regular;
	BOOL isInverted;
	NSButton * invertButton;
}

- (void)invertColors:(id)sender;

@end
