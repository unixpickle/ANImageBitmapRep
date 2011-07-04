//
//  ANImageBitmapRep.h
//  ANImageBitmapRep
//
//  Created by Alex Nichol on 5/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "CGImageContainer.h"
#import "CGContextCreator.h"

@interface ANImageBitmapRep : NSObject {
	CGContextRef ctx;
	CGImageRef img;
	BOOL changed;
	char * bitmapData;
}

/**
 * Creates a new, blank image bitmap with a particular
 * size.
 * @param sz The size to use when creating the bitmap.
 * @return A new image with the specified size.
 */
- (id)initWithSize:(CGSize)size;

/**
 * Create a new image bitmap with a UIImage.
 * @param anImage The image to use for the bitmap.
 * @return The new bitmap.
 */
- (id)initWithImage:(UIImage *)anImage;

/**
 * Returns an image bitmap rep with a UIImage.
 * @param anImage The image to use for the bitmap.
 * @return An autoreleased ANImageBitmapRep with the image.
 */
+ (id)imageBitmapRepWithImage:(UIImage *)anImage;

/**
 * Create an image bitmap with the name of an image resource file.
 * @param resourceName The name of the image file in the application bundle's
 * resources directory.
 * @return An ANImageBitmapRep with the image loaded from the file,
 * or nil if the file was not found.
 */
+ (id)imageBitmapRepNamed:(NSString *)resourceName;

/**
 * Enforces the image bitmap to regenerate the CGImageRef
 * when it is called for.  Only call this after
 * manually modifying the CGContextRef of the bitmap.
 */
- (void)setNeedsUpdate;

/**
 * Blurs the image to a particular factor by resizing it.
 * @param percent A percentage from 0 to 1 that represents
 * the scale that the image should be placed to before being resized
 * back to normal.
 */
- (void)setQuality:(float)percent;

/**
 * Brighten or darken an image to a certain percent.
 * @param percent For this percent, 0 is black, 1 is normal, and 2 is
 * white.  An example would be 0.5, which would represent a half
 * darkened image.
 */
- (void)setBrightness:(float)percent;

/**
 * Get the pixel at a certain x and y coordinate.
 * @param pxl A four float long pointer.  This will be set using
 * pxl[0] = red, pxl[1] = green, pxl[2] = blue, pxl[3] = alpha.
 * The values in this should range from 0 to 1.
 * @param x The x coordinate (starting from 0 ending at width - 1).
 * @param y The y coordinate (starting from 0 ending at height - 1).
 */
- (void)getPixel:(CGFloat *)pxl atX:(int)x y:(int)y;

/**
 * Sets the pixel at a certain x and y coordinate.
 * @param pxl A four float long pointer.  This will be read using
 * red = pxl[0], green = pxl[1], blue = pxl[2], alpha = pxl[3].
 * The values in this should range from 0 to 1.
 * @param x The x coordinate (starting from 0.)
 * @param y The y coordinate (starting from 0.)
 */
- (void)setPixel:(CGFloat *)pxl atX:(int)x y:(int)y;

/**
 * Get the pixel at a certain x and y coordinate.
 * @param pxl A four byte long pointer.  This will be set using
 * pxl[0] = red, pxl[1] = green, pxl[2] = blue, pxl[3] = alpha.
 * The values in this will range from 0 to 255.
 * @param x The x coordinate (starting from 0 ending at width - 1).
 * @param y The y coordinate (starting from 0 ending at height - 1).
 */
- (void)get255Pixel:(unsigned char *)pxl atX:(int)x y:(int)y;

/**
 * Sets the pixel at a certain x and y coordinate.
 * @param pxl A four byte long pointer.  This will be read using
 * red = pxl[0], green = pxl[1], blue = pxl[2], alpha = pxl[3].
 * The values in this should range from 0 to 255.
 * @param x The x coordinate (starting from 0 ending at width - 1).
 * @param y The y coordinate (starting from 0 ending at height - 1).
 */
- (void)set255Pixel:(unsigned char *)pxl atX:(int)x y:(int)y;

/**
 * Draws the image in the current UIGraphicsContext in
 * a specified frame.  This is quite similar to the UIImage -drawInRect:
 * method if you are familiar.
 * @param rect The frame to use for drawing.  If this is not the size
 * of the bitmap, scaling or stretching may occur.
 */
- (void)drawInRect:(CGRect)rect;


/**
 * Get a CGImageRef from the bitmap.  This method will return the same CGImageRef
 * until something internally calls setNeedsUpdate, or it is called externally.
 * @return A non-retained (autoreleased) CGImageRef.  This image is good
 * until the autorelease pool is drained.  It is suggested that you retain
 * the result of this method if you plan on using it for any period of time.
 */
- (CGImageRef)CGImage;

/**
 * Get a fresh UIImage from the bitmap.  This method will always return
 * a new object, even if setNeedsUpdate has not bee called.
 * @return An autoreleased UIImage object with the contents of the
 * image bitmap's CGImage.
 */
- (UIImage *)image;

/**
 * Stretches the image bitmap to a particular size.
 * @param size The new size to make the bitmap.
 * If this is the same as the current size, the bitmap
 * will not be changed.
 */
- (void)setSize:(CGSize)size;

/**
 * Scales the image to fit a particular frame without
 * stretching (bringing out of scale).
 * @param newSize The size to which the image scaled.
 * @discussion The actual image itself will most likely be smaller than
 * the specified size, and there will be transparent edges to padd the image
 * to the exact size.
 */
- (void)setSizeKeepingAspectRatio:(CGSize)newSize;

/**
 * Scales the image to fill a particular frame without
 * stretching the image.  This will most likely cause the left/right or
 * top/bottom edges of the image to get cut off.
 * @param newSize The size to which the image will be forced
 * to fill.
 */
- (void)setSizeFillingWithAspect:(CGSize)newSize;

/**
 * Return the current size of the image.
 * @return The size of the image (rounded.)
 * @discussion This creates a new CGSize every time it is called,
 * and therefore should be called as little as possible to increase
 * application performance.
 */
- (CGSize)size;

/**
 * Copies a portion of pixels from the image bitmap, and returns
 * that portion in a new image bitmap.
 * @param nRect The frame from which to cut the new image.
 * If this frame doesn't perfectly intersect with the images bounds,
 * the excess parts of the returned image will be fully transparent.
 * @return An autoreleased image bitmap that has been cropped.  This image
 * will have the dimensions of @param nRect.
 */
- (ANImageBitmapRep *)cropWithFrame:(CGRect)nRect;

/**
 * Returns the graphics context for the image.  If the context is
 * drawn upon, it is important to call the -setNeedsUpdate
 * method on the ANImageBitmapRep to which it belongs.
 * @return The graphics context underlying the image bitmap.
 */
- (CGContextRef)graphicsContext;

/**
 * Applies a classic color inversion to an image.
 */
- (void)invertColors;

/**
 * Rotate the image around its center.
 * @param degrees Measured in degrees, not radians.  This is the angle
 * used for rotation.
 * @return An autoreleased image bitmap that is the result of the rotation.
 * The returned image will most likely have different dimensions to fit the corners
 * which have been moved.
 */
- (ANImageBitmapRep *)rotate:(float)degrees;

@end

@interface UIImage (ANImageBitmapRep)

- (ANImageBitmapRep *)imageBitmapRep;
- (UIImage *)scaleToSize:(CGSize)sz;
- (UIImage *)aspectScaleToSize:(CGSize)sz;
- (UIImage *)fillAspectWithSize:(CGSize)sz;

@end
