//
//  ANImageBitmapRep.h
//  ANImageBitmapRep
//
//  Created by Alex Nichol on 5/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ANImageBitmapRep : NSObject {
	CGContextRef ctx;
	CGImageRef img;
	BOOL changed;
	char * bitmapData;
}


// static methods for creating contexts
+ (CGContextRef)CreateARGBBitmapContextWithSize:(CGSize)size;
+ (CGContextRef)CreateARGBBitmapContextWithImage:(CGImageRef)image;

// create a blank ANImageBitmapRep with a size
- (id)initWithSize:(CGSize)sz;
// create an ANImageBitmapRep with the size and pixels of _img.
- (id)initWithImage:(UIImage *)_img;

// return the autorelease ANImageBitmapRep equivalent
// to initWithImage:_img
+ (id)imageBitmapRepWithImage:(UIImage *)_img;
// same as above, but calls [UIImage imageNamed:_resourceName];
+ (id)imageBitmapRepNamed:(NSString *)_resourceName;

// after this is called, CGImage will create a new image
// exactly once.
- (void)setNeedsUpdate;
// scale down, then scale back up for blur effect.
- (void)setQuality:(float)percent;
// brighten up the image (1.0 = normal, 0 = black, 2 = white)
- (void)setBrightness:(float)percent;

// get the RGBA pixel in a four element CGFloat pointer.
- (void)getPixel:(CGFloat *)pxl atX:(int)x y:(int)y;
// set the RGBA pixel at a point.
- (void)setPixel:(CGFloat *)pxl atX:(int)x y:(int)y;
// get an 8-bit/pixel RGB pointer at an x and y.
// this and set255Pixel: are more efficient than using
// floating points.
- (void)get255Pixel:(char *)pxl atX:(int)x y:(int)y;
// set an 8-bit/pixel RGB pointer at an x and y.
- (void)set255Pixel:(char *)pxl atX:(int)x y:(int)y;
// draw in the current context, in a rectangle: r.
- (void)drawInRect:(CGRect)r;


// get a retained CGImageRef from the bitmap rep
- (CGImageRef)CGImage;
// get an autoreleased UIImage from the bitmap rep.
- (UIImage *)image;

// scale the image to size.
- (void)setSize:(CGSize)size;
// scale, keeping the aspect
- (void)setSizeKeepingAspectRatio:(CGSize)newSize;
// get the size of the image.
// reduce the calling of this
// method!
- (CGSize)size;
// instead of resizing the image, 
// crop out a certain rectangle
- (ANImageBitmapRep *)cropWithFrame:(CGRect)nRect;
// get the bitmap context
- (CGContextRef)graphicsContext;

// reverse the colors of the image
- (void)invertColors;
// rotate the image, creating a new
// sized image.
- (ANImageBitmapRep *)rotate:(float)degrees;

@end

@interface UIImage (ANImageBitmapRep)

- (ANImageBitmapRep *)imageBitmapRep;
- (UIImage *)scaleToSize:(CGSize)sz;
- (UIImage *)aspectScaleToSize:(CGSize)sz;

@end
