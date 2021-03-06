//
//  RootViewController.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorInverter.h"
#import "Blur.h"
#import "Noise.h"
#import "Draw.h"
#import "Rotation.h"
#import "GetPixel.h"

@interface RootViewController : UITableViewController {
#if __has_feature(objc_arc) == 1
    __strong NSArray * views;
#else
    NSArray * views;
#endif
}

@end
