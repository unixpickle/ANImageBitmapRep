//
//  ANImageBitmapRep.m
//  ANImageBitmapRep
//
//  Created by Alex Nichol on 5/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ANImageBitmapRep.h"

#define DEGTORAD(x) (x * (M_PI / 180.0f))

static CGPoint locationForAngle (CGFloat angle, CGFloat hypotenuse) {
	// get the corner
	CGPoint p;
	p.x = (CGFloat)cos((double)DEGTORAD(angle)) * hypotenuse;
	p.y = (CGFloat)sin((double)DEGTORAD(angle)) * hypotenuse;
	return p;
}

@implementation ANImageBitmapRep

- (id)initWithSize:(CGSize)size {
	NSAssert(size.width > 0 && size.height > 0, @"Cannot create an image of specified size.");
	if ((self = [super init])) {
		// load the image into the context
		ctx = [CGContextCreator newARGBBitmapContextWithSize:size];
		if (ctx == NULL) {
			[super dealloc];
			return nil;
		}
		bitmapData = CGBitmapContextGetData(ctx);
		[self setNeedsUpdate];
	}
	return self;
}

- (id)initWithImage:(UIImage *)anImage {
	if ((self = [super init])) {
		// load the image into the context
		if (!anImage) {
			[super dealloc];
			return nil;
		}
		img = CGImageRetain([anImage CGImage]);
		ctx = [CGContextCreator newARGBBitmapContextWithImage:img];
		bitmapData = CGBitmapContextGetData(ctx);
	}
	return self;
}

+ (id)imageBitmapRepWithImage:(UIImage *)_img {
	return [[[ANImageBitmapRep alloc] initWithImage:_img] autorelease];
}

+ (id)imageBitmapRepNamed:(NSString *)_resourceName {
	// we wanna use an autorelease pool here
	// to make sure we don't retain
	// the UIImage imageNamed: image.
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	ANImageBitmapRep * rep = [[ANImageBitmapRep alloc] initWithImage:[UIImage imageNamed:_resourceName]];
	[pool drain];
	return [rep autorelease];
}

#pragma mark Getting Properties

- (CGSize)size {
	return CGSizeMake(CGBitmapContextGetWidth(ctx), CGBitmapContextGetHeight(ctx));
}

- (CGContextRef)graphicsContext {
	return ctx;
}

- (CGImageRef)CGImage {
	if (!changed) {
		// container retains the image, and will release it
		// when the autorelease pool is drained.
		CGImageContainer * container = [CGImageContainer imageContainerWithImage:img];
		return [container image];
	} else {
		CGImageRelease(img);
		img = CGBitmapContextCreateImage(ctx);
		changed = NO;
		return [[CGImageContainer imageContainerWithImage:img] image];
	}
}

- (UIImage *)image {
	CGImageRef _img = [self CGImage];
	// I don't know how UIImage deals with these things.
	return [UIImage imageWithCGImage:_img];
}

- (void)getPixel:(CGFloat *)pxl atX:(int)x y:(int)y {
	CGSize s = [self size];
	unsigned char * c = (unsigned char *)&bitmapData[((y * (int)(s.width))+x) * 4];
	// convert from ARGB to RGBA
	float alpha = ((float)c[0]) / 255.0f;
	pxl[0] = ((float)((float)(int)(c[1])) / 255.0f) / alpha;
	pxl[1] = ((float)((float)c[2]) / 255.0f) / alpha;
	pxl[2] = ((float)((float)c[3]) / 255.0f) / alpha;
	pxl[3] = ((float)(c[0]) / 255.0f);
	
	if (pxl[0] > 1) pxl[0] = 1;
	if (pxl[1] > 1) pxl[1] = 1;
	if (pxl[2] > 1) pxl[2] = 1;
	if (pxl[3] > 1) pxl[3] = 1;
}

- (void)get255Pixel:(unsigned char *)pxl atX:(int)x y:(int)y {
	CGSize s = [self size];
	unsigned char * c = (unsigned char *)&bitmapData[((y * (int)(s.width))+x) * 4];
	pxl[0] = c[1];
	pxl[1] = c[2];
	pxl[2] = c[3];
	pxl[3] = c[0];
}

#pragma mark Setting Properties

- (void)setNeedsUpdate {
	changed = YES;
}

- (void)setSize:(CGSize)theSize {
	NSAssert(theSize.width > 0 && theSize.height > 0, @"Cannot create an image of specified size.");
	CGSize size = CGSizeMake((CGFloat)round((double)theSize.width), (CGFloat)round((double)theSize.height));
	CGImageRef _img = [self CGImage];
	
	CGContextRef _ctx = [CGContextCreator newARGBBitmapContextWithSize:size];
	CGContextRelease(ctx);
	free(bitmapData);
	
	ctx = _ctx;
	bitmapData = CGBitmapContextGetData(_ctx);
	
	CGContextClearRect(ctx, CGRectMake(0, 0, size.width, size.height));
	CGContextDrawImage(ctx, CGRectMake(0, 0, size.width, size.height), _img);
	
	[self setNeedsUpdate];
}

- (void)setSizeKeepingAspectRatio:(CGSize)newSize {
	NSAssert(newSize.width > 0 && newSize.height > 0, @"Cannot create an image of specified size.");
	CGSize oldSize = [self size];
	float wratio = oldSize.width / newSize.width;
	float hratio = oldSize.height / newSize.height;
	float scaleRatio;
	if (wratio > hratio) {
		scaleRatio = wratio;
	} else {
		scaleRatio = hratio;
	}
	scaleRatio = 1.0f / scaleRatio;
	
	CGSize newDrawSize = CGSizeMake(oldSize.width * scaleRatio, 
									oldSize.height * scaleRatio);
	
	CGImageRef _img = [self CGImage];
	
	CGContextRef _ctx = [CGContextCreator newARGBBitmapContextWithSize:newSize];
	CGContextRelease(ctx);
	free(bitmapData);
	// image will still be retained.
	
	ctx = _ctx;
	bitmapData = CGBitmapContextGetData(_ctx);
	
	CGContextClearRect(ctx, CGRectMake(0, 0, newSize.width, newSize.height));
	CGContextDrawImage(ctx, CGRectMake(newSize.width / 2 - (newDrawSize.width / 2),
									   newSize.height / 2 - (newDrawSize.height / 2),
									   newDrawSize.width, newDrawSize.height), _img);
	
	[self setNeedsUpdate];
}

- (void)setSizeFillingWithAspect:(CGSize)newSize {
	NSAssert(newSize.width > 0 && newSize.height > 0, @"Cannot create an image of specified size.");
	CGSize oldSize = [self size];
	float wratio = oldSize.width / newSize.width;
	float hratio = oldSize.height / newSize.height;
	float scaleRatio;
	if (wratio < hratio) {
		scaleRatio = wratio;
	} else {
		scaleRatio = hratio;
	}
	scaleRatio = 1.0f / scaleRatio;
	
	CGSize newDrawSize = CGSizeMake(oldSize.width * scaleRatio, 
									oldSize.height * scaleRatio);
	
	CGImageRef _img = [self CGImage];
	
	CGContextRef _ctx = [CGContextCreator newARGBBitmapContextWithSize:newSize];
	CGContextRelease(ctx);
	free(bitmapData);
	// image will still be retained.
	
	ctx = _ctx;
	bitmapData = CGBitmapContextGetData(_ctx);
	
	CGContextClearRect(ctx, CGRectMake(0, 0, newSize.width, newSize.height));
	CGContextDrawImage(ctx, CGRectMake(newSize.width / 2 - (newDrawSize.width / 2),
									   newSize.height / 2 - (newDrawSize.height / 2),
									   newDrawSize.width, newDrawSize.height), _img);
		
	[self setNeedsUpdate];
}

- (void)setBrightness:(float)percent {
	if (percent > 1) {
		int width, height;
		CGSize s = [self size];
		width = (int)(s.width);
		height = (int)(s.height);
		int bytes = width * height * 4;
		for (int i = 0; i < bytes; i++) {
			if (i % 4 != 0) {
				int c = (int)((float)((unsigned char)(bitmapData[i])) * percent);
				if (c > 255) c = 255;
				bitmapData[i] = (char)(c);
			}
		}
		[self setNeedsUpdate];
		return;
	}
	CGSize s = [self size];
	CGContextSaveGState(ctx);
	CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:(1.0f - percent)] CGColor]);
	CGContextFillRect(ctx, CGRectMake(0, 0, s.width, s.height));
	CGContextRestoreGState(ctx);
	[self setNeedsUpdate];
}

- (void)setQuality:(float)percent {
	if (percent == 1.0) return;
	CGSize s = [self size];
	CGSize back = [self size];
	s.width *= percent;
	s.height *= percent;
	[self setSize:s];
	[self setSize:back];
}

- (void)setPixel:(CGFloat *)pxl atX:(int)x y:(int)y {
	CGSize s = [self size];
	float alpha = pxl[3];
	unsigned char * c = (unsigned char *)&bitmapData[((y * (int)(s.width))+x) * 4];
	// convert from ARGB to RGBA
	int i1 = (int)((float)(pxl[3]) * 255.0f);
	int i2 = (int)((float)(pxl[0]) * 255.0f * alpha);
	int i3 = (int)((float)(pxl[1]) * 255.0f * alpha);
	int i4 = (int)((float)(pxl[2]) * 255.0f * alpha);
	
	if (i1 < 0) i1 = 0; else if (i1 > 255) i1 = 255;
	if (i2 < 0) i2 = 0; else if (i2 > 255) i2 = 255;
	if (i3 < 0) i3 = 0; else if (i3 > 255) i3 = 255;
	if (i4 < 0) i4 = 0; else if (i4 > 255) i4 = 255;
	
	c[0] = (char)(i1);
	c[1] = (char)(i2);
	c[2] = (char)(i3);
	c[3] = (char)(i4);
	[self setNeedsUpdate];
}


- (void)set255Pixel:(unsigned char *)pxl atX:(int)x y:(int)y {
	CGSize s = [self size];
	unsigned char * c = (unsigned char *)&bitmapData[((y * (int)(s.width))+x) * 4];
	c[1] = pxl[0];
	c[2] = pxl[1];
	c[3] = pxl[2];
	c[0] = pxl[3];
	[self setNeedsUpdate];
}

#pragma mark Drawing

- (void)drawInRect:(CGRect)r {
	if (r.size.width <= 0 || r.size.height <= 0) return;
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (!context) {
		NSLog(@"Cannot draw yet.");
		return;
	}
	
	CGImageRef image = [self CGImage];
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, 0, CGBitmapContextGetHeight(context));
	CGContextScaleCTM(context, 1.0f, -1.0f);
	CGContextDrawImage(context, CGRectMake(r.origin.x, 
										   (CGBitmapContextGetHeight(context) - r.origin.y) - r.size.height,
										   r.size.width, r.size.height),
					   image);
	CGContextRestoreGState(context);
}

#pragma mark Newbie Features

- (ANImageBitmapRep *)cropWithFrame:(CGRect)nRect {
	NSAssert(nRect.size.width > 0 && nRect.size.height > 0, @"Cannot create an image of specified size.");
	ANImageBitmapRep * irep = [[ANImageBitmapRep alloc] initWithSize:nRect.size];
	CGRect r;
	r.size = [self size];
	r.origin.x = -(nRect.origin.x);
	r.origin.y = -(r.size.height - (nRect.origin.y + nRect.size.height));
	CGContextRef _ctx = [irep graphicsContext];
	CGContextDrawImage(_ctx, r, [self CGImage]);
	[irep setNeedsUpdate];
	return [irep autorelease];
}

- (ANImageBitmapRep *)rotate:(float)degrees {
	if (degrees == 0) {
		return [[self retain] autorelease];
	}
	// rotate the image
	CGSize size = self.size;
	CGSize newSize;
	
	// calculate new size
	CGFloat hypotenuse;
	hypotenuse = (CGFloat)sqrt(pow((double)size.width / 2.0, 2.0) + pow((double)size.height / 2.0, 2.0));
	
	CGPoint minP = CGPointMake(10000, 10000);
	CGPoint maxP = CGPointMake(-10000, -10000);
	
	// Find the angles at which the corners are before the rotation.
	float firstAngle = (float)atan2((double)size.height / 2.0, (double)size.width / 2.0);
	float secondAngle = (float)atan2((double)size.height / 2.0, (double)size.width / -2.0);
	float thirdAngle = (float)atan2((double)size.height / -2.0, (double)size.width / -2.0);
	float fourthAngle = (float)atan2((double)size.height / -2.0, (double)size.width / 2.0);
	float angles[4] = {firstAngle, secondAngle, thirdAngle, fourthAngle};
	
	// Rotate the corners by the new degrees, finding out how outgoing
	// the corners will be.  This will allow us to easily calculate
	// the new size of the image.
	for (int i = 0; i < 4; i++) {
		// conver the angle to radians.
		float deg = angles[i] * (float)(180.0f / M_PI);
		CGPoint p1 = locationForAngle(deg + degrees, hypotenuse);
		if (p1.x < minP.x) minP.x = p1.x;
		if (p1.x > maxP.x) maxP.x = p1.x;
		if (p1.y < minP.y) minP.y = p1.y;
		if (p1.y > maxP.y) maxP.y = p1.y;
	}
	
	newSize.width = maxP.x - minP.x;
	newSize.height = maxP.y - minP.y;
	
	// Figure out where the thing is going to go when rotated by the bottom left
	// corner.  Use that information to translate it so that it rotates from the center.
	hypotenuse = (CGFloat)sqrt((pow(newSize.width / 2.0, 2) + pow(newSize.height / 2.0, 2)));
	CGPoint newCenter;
	float addAngle = (float)atan2((double)newSize.height / 2, (double)newSize.width / 2) * (float)(180.0f / M_PI);
	newCenter.x = cos((float)DEGTORAD((degrees + addAngle))) * hypotenuse;
	newCenter.y = sin((float)DEGTORAD((degrees + addAngle))) * hypotenuse;
	CGPoint offsetCenter;
	offsetCenter.x = (float)((float)newSize.width / 2.0f) - (float)newCenter.x;
	offsetCenter.y = (float)((float)newSize.height / 2.0f) - (float)newCenter.y;
	
	ANImageBitmapRep * newBitmap = [[ANImageBitmapRep alloc] initWithSize:newSize];
	
	CGContextRef context = [newBitmap graphicsContext];
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, (float)round((float)offsetCenter.x), (float)round((float)offsetCenter.y));
	
	CGContextRotateCTM(context, (CGFloat)DEGTORAD(degrees));
	CGRect drawRect;
	drawRect.size = size;
	drawRect.origin.x = (CGFloat)round((newSize.width / 2) - (size.width / 2));
	drawRect.origin.y = (CGFloat)round((newSize.height / 2) - (size.height / 2));
	CGContextDrawImage(context, drawRect, [self CGImage]);
	CGContextRestoreGState(context);
	
	[newBitmap setNeedsUpdate];
	
	return [newBitmap autorelease];
}

- (void)invertColors {
	ANImageBitmapRep * rep = self;
	CGSize s = [rep size];
	
	for (int y = 0; y < s.height; y++) {
		for (int x = 0; x < s.width; x++) {
			unsigned char * c = (unsigned char *)&bitmapData[((y * (int)(s.width))+x) * 4];
			c[1] = 255 - c[1];
			c[2] = 255 - c[2];
			c[3] = 255 - c[3];
		}
	}
	
	[self setNeedsUpdate];
}

- (void)dealloc {
	CGImageRelease(img);
	CGContextRelease(ctx);
	free(bitmapData);
	[super dealloc];
}

@end

@implementation UIImage (ANImageBitmapRep)

- (ANImageBitmapRep *)imageBitmapRep {
	return [[[ANImageBitmapRep alloc] initWithImage:self] autorelease];
}

- (UIImage *)scaleToSize:(CGSize)sz {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	ANImageBitmapRep * irep = [self imageBitmapRep];
	[irep setSize:sz];
	UIImage * img = [[irep image] retain];
	[pool drain];
	return [img autorelease];
}

- (UIImage *)aspectScaleToSize:(CGSize)sz {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	ANImageBitmapRep * irep = [self imageBitmapRep];
	[irep setSizeKeepingAspectRatio:sz];
	UIImage * img = [[irep image] retain];
	[pool drain];
	return [img autorelease];
}

- (UIImage *)fillAspectWithSize:(CGSize)sz {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	ANImageBitmapRep * irep = [self imageBitmapRep];
	[irep setSizeFillingWithAspect:sz];
	UIImage * img = [[irep image] retain];
	[pool drain];
	return [img autorelease];
}

@end
