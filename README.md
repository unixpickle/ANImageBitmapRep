Important
=========

This project uses submodules as such you must use the `--recursive` flag when cloning the project like this:

    git clone --recursive git@github.com:bguest/RSColorPicker.git
    
If this doesn't work it's probably due to the fact that you are using an older version of git, update git and try again.

# ANImageBitmapRep

This is a class that Alex Nichol have been working on for a while now.  It was originally made only for managing the bitmap data of a UIImage, but has evolved quite a bit throughout the years that he has used it.  It currently allows for scaling, access ti bitmap data, drawing (using core graphics), cropping, rotating, and more.  Because ANImageBitmapRep encapsulates a CGContextRef, it's easy to throw in your own image manipulation code simply by drawing on the CGContextRef.

## The History

A while ago (in 2009) Alex decided that he needed a way to access the bitmap data of an image.  This was when ANImageBitmapRep was born.  I original created this class based on the existing Cocoa class, NSBitmapImageRep, which is not available on the iPhone.

This simple class later evolved due to my needs while using it in different apps.  Most of the time when He makes an app that uses this, Alex ends up adding something to the class that was not there before.  It was silly of him to not post this to GitHub a long time ago, because Alex finds myself using ANImageBitmapRep constantly, and He bets other people out there could use it too!

In July, 2011, Alex decided to re-structure my Image Bitmap Rep classes to be more organized as well as more efficient.  My remake included adding various levels of subclasses to ANImageBitmapRep which provide basic to advanced functionality.  The ANImageBitmapRep class provides a few miscellaneous features, but mainly takes its functionality from its subclasses.

In November of 2011, Ben decided to start using the core functionality of ANImageBitmapRep in [RSColorPicker](https://github.com/bguest/RSColorPicker), so he extracted the key classes and made them a submodule. Yeah, Ben knows no one knows how to use submodules, but this is what they were designed to do, so now might be a good time to learn about them. Ben also realized that using a chain of subclasses to create multiple inhearances was a really contorted was kind of strange, so he changed the subclasses to catagories.

## The Usage

In order to use an ANImageBitmapRep for an image, you have to create one first.  This can be done either by using an existing UIImage, or creating a blank ANImageBitmapRep with given dimensions.  Both can be done through the following initializers:

    - (id)initWithImage:(UIImage *)image;
    - (id)initWithSize:(BMPoint)sizePoint;

Interacting with bitmap data has never been as easy as it should.  That's why ANImageBitmapRep provides simple functions to get and set individual pixels at any given location in the bitmap.  The BMPixel structure holds RGBA values, and is generally what is used for interacting with pixels.  For instance, getting the pixel at (0,0) on a bitmap looks something like this:

    BMPixel pixel = [image getPixelAtPoint:BMPointMake(0, 0)];
    NSLog(@"Red: %f", pixel.red);
    NSLog(@"Green: %f", pixel.green);
    NSLog(@"Blue: %f", pixel.blue);

Let's say we get a pixel, and we want to set the red value to be 100%.  We can change our pixel and set it in the bitmap like this:

    pixel.red = 1;
    [image setPixel:pixel atPoint:BMPointMake(0, 0)];

Once you are finished interacting with bitmap data, you can get a UIImage from a bitmap with the <tt>-image</tt> method:
    
    UIImage * anImage = [image image];

How about scaling, cropping, and resizing you might ask?  ANImageBitmapRep provides all of those features as easy-to-use methods.  The <tt>-setSize:</tt>, <tt>-setSizeFittingFrame:</tt>, and <tt>-setSizeFillingFrame:</tt> methods are good for all kinds of resizing and scaling.  For instance, if we have an ANImageBitmapRep that is 100x100 pixels large, and we want to stretch it to 300x200, we could do:

    [image setSize:BMPointMake(300, 200)];

You can read more about the <tt>-setSize*:</tt> methods in <tt>ScalableBitmapRep.h</tt>.  Cropping is done in a similar manner.  Let's say we have an image that is 200 by 200, and we want to cut out the middle 50 pixels of it (which would be {(75, 75),(50, 50)}).  We can do this with the <tt>-cropFrame:</tt> method.

    [image cropFrame:CGRectMake(75, 75, 50, 50)];

Finally, what is an image if it's not spinning around in a nauseating way?  In <tt>RotatableBitmapRep.h</tt> you will see a method called <tt>-rotate:</tt>.  This method takes a value from zero to 360 that represents an angle.  Let's say we have an image that we want to rotate by 120 degrees.  We can simply do the following:

    [image rotate:120];

Well, that concludes our basic usage overview.  You can find more information on some of these methods in their headers.  I follow a strict Doxygen/Javadoc format for function descriptions, so it should be pretty simple to read what each of them do.

## When Will I Add To It?

Every time I make a new app that requires something new from ANImageBitmapRep, I make an addition to the class.  A classic example is when I was making my app Zoomify.  I needed a way to crop a part of an ANImageBitmapRep, so I added the <tt>cropWithFrame:</tt> method.  This means that whenever I am working on an app that needs a new image-related feature, you can expect to see an update to this class!

## Good Examples?

The Xcode project included with this code is a demo of what ANImageBitmapRep is capable of.  It doesn't include a demo of all the features, but it shows off the simpler things that you can do with it.  I will definitely be adding more demos to this project in the future, so stay tuned!
