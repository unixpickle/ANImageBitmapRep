//
//  GetPixel.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetPixelDemo.h"

@interface GetPixel : UIViewController <GetPixelDemoDelegate> {
#if __has_feature(objc_arc) == 1
	__strong GetPixelDemo * demoView;
	__strong UIView * pxlView;
#else
    GetPixelDemo * demoView;
	UIView * pxlView;
#endif
}

@end
