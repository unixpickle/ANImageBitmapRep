//
//  GetPixelDemo.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANImageBitmapRep.h"

@protocol GetPixelDemoDelegate <NSObject>

- (void)pixelDemoGotPixel:(BMPixel)pixel;

@end

@interface GetPixelDemo : UIView {
    id<GetPixelDemoDelegate> delegate;
	ANImageBitmapRep * image;
}

@property (nonatomic, assign) id<GetPixelDemoDelegate> delegate;

- (id)initWithFrame:(CGRect)frame image:(ANImageBitmapRep *)theImage;

@end
