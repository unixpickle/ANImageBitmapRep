//
//  ANBlurView.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANBlurDemo.h"

@implementation ANBlurDemo

+ (NSString *)demoDisplayName {
    return @"Blur";
}

- (id)initWithFrame:(NSRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        blurView = [[NSImageView alloc] initWithFrame:NSMakeRect(10, 10, frameRect.size.width - 20, 300)];
        qualityLevel = [[NSSlider alloc] initWithFrame:NSMakeRect(10, 320, frameRect.size.width - 20, 24)];
        [qualityLevel setDoubleValue:0];
        [qualityLevel setMaxValue:0.96];
        [qualityLevel setTarget:self];
        [qualityLevel setAction:@selector(qualityChanged:)];
        [self qualityChanged:qualityLevel];
        [self addSubview:blurView];
        [self addSubview:qualityLevel];
    }
    return self;
}

- (void)setQuality:(float)percentage {
    if (!original) {
        original = [ANImageBitmapRep imageBitmapRepWithImage:[NSImage imageNamed:@"blurtest"]];
    }
    ANImageBitmapRep * newImage = [original copy];
    [newImage setQuality:percentage];
    [blurView setImage:[newImage image]];
}

- (void)qualityChanged:(id)sender {
    [self setQuality:(1 - [qualityLevel doubleValue])];
}

@end
