//
//  ANAppDelegate.h
//  MacImageRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANBlurDemo.h"
#import "ANInverterDemo.h"
#import "ANNoiseDemo.h"

@interface ANAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource> {
	IBOutlet NSTableView * tableView;
	IBOutlet NSView * contentView;
	NSArray * demoObjects;
	ANDemoView * currentDemo;
}

@property (assign) IBOutlet NSWindow * window;

- (void)setSelectedView:(int)viewIndex;

@end
