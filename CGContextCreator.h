//
//  CGContextCreator.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGContextCreator : NSObject {
    
}

+ (CGContextRef)newARGBBitmapContextWithSize:(CGSize)size;
+ (CGContextRef)newARGBBitmapContextWithImage:(CGImageRef)image;

@end
