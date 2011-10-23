//
//  ANBlurView.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANDemoView.h"
#import "ANImageBitmapRep.h"

@interface ANBlurDemo : ANDemoView {
	NSImageView * blurView;
	NSSlider * qualityLevel;
	ANImageBitmapRep * original;
}

- (void)setQuality:(float)percentage;
- (void)qualityChanged:(id)sender;

@end
