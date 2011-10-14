//
//  BitmapContextManip.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BitmapContextManipulator.h"

@implementation BitmapContextManipulator

@synthesize context;

- (id)initWithContext:(BitmapContextRep *)aContext {
	if ((self = [super init])) {
		self.context = aContext;
	}
	return self;
}

- (void)dealloc {
	self.context = nil;
	[super dealloc];
}

@end
