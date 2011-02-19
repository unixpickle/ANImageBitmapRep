//
//  Rotation.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 2/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANImageBitmapRep.h"

@interface Rotation : UIViewController {
	IBOutlet UIImageView * rotatedImage;
	IBOutlet UISlider * angle;
	ANImageBitmapRep * rotateMe;
}

- (IBAction)rotation:(id)sender;

@end
