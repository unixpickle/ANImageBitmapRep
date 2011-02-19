# ANImageBitmapRep

This is a class that I have been working on for a long time.  It was originally made only for managing the bitmap data of an image on the iPhone, but it has evolved quite a bit throughout the months that I have used it.  It currently allows for scaling, bitmap data access, drawing (using core graphics), brightness changes, cropping, and rotating.  Since this encapsulates a CoreGraphics context, it is easy to take control of what the class does, if it doesn't already have a feature for it.

## The History

A long while ago in 2009, I decided that I needed a way to access the bitmap data of an image.  This was when ANImageBitmapRep was born.  I original created this class based on the existing Cocoa class, NSBitmapImageRep, which is not available on the iPhone.

This simple class later evolved, due to my needs while using it in different apps.  Most of the time when I make an app that uses this, I end up adding something to the class that was not there before.  It was silly of me to not post this to GitHub a long while ago, because it is quite helpful for about everything involving image editing.

## The Usage

This class works in a very simple way, which you would probably expect.  There is an ANImageBitmapRep class which you can initialize with a particular size, or UIImage.  The class itself uses a CGContextRef to back the image, and allocates the bitmap data itself.  Pixel data can be accessed through the <tt>getPixel:atX:y:</tt> and <tt>setPixel:atX:y:</tt> method.  You can draw it in the current graphics context of UIKit by calling the <tt>drawInRect:</tt> method.

Since this is for image management and editing, you can easily obtain a UIImage from any ANImageBitmapRep object.  Do this by calling the <tt>image</tt> method on an ANImageBitmapRep object.  There is also a <tt>CGImage</tt> method, which returns a CGImageRef, which must be released (unlike the autoreleased UIImage from the image method).

Unlike normal UIImage objects, you can easily resize an ANImageBitmapRep object.  This can be done through the <tt>setSize:</tt> method.  There is also a function to crop another ANImageBitmapRep from the image, which is called <tt>cropWithFrame:</tt>.  There are other features in this class that I have not mentioned in this README file, which you should definitely check out in ANImageBitmapRep.h, which contains all of the public method declarations.

## When Will I Add to it?

Every time I make a new app that requires something new from ANImageBitmapRep, I make an addition to the class.  A classic example is when I was making my app Zoomify.  I needed a way to crop a part of an ANImageBitmapRep, so I added the <tt>cropWithFrame:</tt> method.  This means that whenever I am working on an app that needs a new image-related feature, you can expect to see an update to this class!

## Good Examples?

The Xcode project included with this code is a demo of what ANImageBitmapRep is capable of.  It doesn't include a demo of all the features, but it shows off the simpler things that you can do with it.  I will definitely be adding more demos to this project in the future, so stay tuned!

Another thing to note is that the ImageBitmapRep Xcode project consists of two targets.  One is the demo application, and the other is a static library of the class itself.  I am not saying that you have to use the static library, but in general it is more convenient.  You have to cary around less code in your app, and you never have to recompile ANImageBitmapRep (unless of course I change the class itself.)
