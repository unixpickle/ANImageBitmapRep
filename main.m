//
//  main.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	int retVal;
#if __has_feature(objc_arc) == 1
	@autoreleasepool {
#else
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
#endif
	retVal = UIApplicationMain(argc, argv, nil, nil);
#if __has_feature(objc_arc) == 1
	}
#else
	[pool drain];
#endif
	return retVal;
}
