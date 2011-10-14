//
//  ScalableBitmapRep.m
//  ImageManip
//
//  Created by Alex Nichol on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BitmapScaleManipulator.h"


@implementation BitmapScaleManipulator

- (void)setSize:(BMPoint)aSize {
	CGContextRef newContext = [CGContextCreator newARGBBitmapContextWithSize:CGSizeMake(aSize.x, aSize.y)];
	CGImageRef image = [context CGImage];
	CGContextDrawImage(newContext, CGRectMake(0, 0, aSize.x, aSize.y), image);
	[context setContext:newContext];
	CGContextRelease(newContext);
}

- (void)setSizeFittingFrame:(BMPoint)aSize {
	CGSize oldSize = CGSizeMake([context bitmapSize].x, [context bitmapSize].y);
	CGSize newSize = CGSizeMake(aSize.x, aSize.y);
	
	float wratio = newSize.width / oldSize.width;
	float hratio = newSize.height / oldSize.height;
	float scaleRatio;
	if (wratio < hratio) {
		scaleRatio = wratio;
	} else {
		scaleRatio = hratio;
	}
	scaleRatio = scaleRatio;
	
	CGSize newContentSize = CGSizeMake(oldSize.width * scaleRatio, oldSize.height * scaleRatio);
	CGImageRef image = [context CGImage];
	CGContextRef newContext = [CGContextCreator newARGBBitmapContextWithSize:CGSizeMake(aSize.x, aSize.y)];
	CGContextDrawImage(newContext, CGRectMake(newSize.width / 2 - (newContentSize.width / 2),
											  newSize.height / 2 - (newContentSize.height / 2),
											  newSize.width, newContentSize.height), image);
	[self setContext:context];
	CGContextRelease(newContext);
}

- (void)setSizeFillingFrame:(BMPoint)aSize {
	CGSize oldSize = CGSizeMake([context bitmapSize].x, [context bitmapSize].y);
	CGSize newSize = CGSizeMake(aSize.x, aSize.y);
	
	float wratio = newSize.width / oldSize.width;
	float hratio = newSize.height / oldSize.height;
	float scaleRatio;
	if (wratio > hratio) { // only difference from -setSizeFittingFrame:
		scaleRatio = wratio;
	} else {
		scaleRatio = hratio;
	}
	scaleRatio = scaleRatio;
	
	CGSize newContentSize = CGSizeMake(oldSize.width * scaleRatio, oldSize.height * scaleRatio);
	CGImageRef image = [context CGImage];
	CGContextRef newContext = [CGContextCreator newARGBBitmapContextWithSize:CGSizeMake(aSize.x, aSize.y)];
	CGContextDrawImage(newContext, CGRectMake(newSize.width / 2 - (newContentSize.width / 2),
											  newSize.height / 2 - (newContentSize.height / 2),
											  newSize.width, newContentSize.height), image);
	[self setContext:context];
	CGContextRelease(newContext);
}

@end
