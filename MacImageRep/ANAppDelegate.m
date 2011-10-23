//
//  ANAppDelegate.m
//  MacImageRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANAppDelegate.h"

@implementation ANAppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	demoObjects = [NSArray arrayWithObjects:[ANBlurDemo class], [ANInverterDemo class],
				   [ANNoiseDemo class], nil];
	[tableView setDelegate:self];
	[tableView setDataSource:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return YES;
}

- (void)setSelectedView:(int)viewIndex {
	if (currentDemo) {
		[currentDemo removeFromSuperview];
		currentDemo = nil;
	}
	if (viewIndex >= 0 && viewIndex < [demoObjects count]) {
		Class demoClass = [demoObjects objectAtIndex:viewIndex];
		ANDemoView * demo = [(ANDemoView *)[demoClass alloc] initWithFrame:contentView.bounds];
		[contentView addSubview:demo];
		currentDemo = demo;
	}
}

#pragma mark Table View

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	return [[demoObjects objectAtIndex:row] demoDisplayName];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	return [demoObjects count];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
	[self setSelectedView:(int)[tableView selectedRow]];
}

@end
