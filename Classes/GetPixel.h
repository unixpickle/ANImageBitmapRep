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
    GetPixelDemo * demoView;
	UIView * pxlView;
}

@end
