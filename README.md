PostcardUIActivity
==================

A UIActivity that launches the Sincerely postcard ordering process from a UIActivityViewController.

![](http://farm8.staticflickr.com/7426/10048377684_209a3a94e1.jpg)

This has been tested on iPhones running iOS7. If you try it on a different device or iOS version,
let me know how it works for you!


How To Use It
=============
First, you need an Application Key from Sincerely. You can get an Application Key by going to 
http://dev.sincerely.com and requesting one. Follow their instructions for adding ShipLib to
your project.

Next, download this project and drag the .h, .m, and .png files to your application.

Then, create an instance of PostcardUIActivity and add it to your UIActivityViewController
before it is displayed:

    PostcardUIActivity *postcardUIActivity = 
        [[PostcardUIActivity alloc] 
            initWithApplicationKey:@"YourApplicationKeyGoesHere"];    
    UIActivityViewController *activityViewController = 
        [[UIActivityViewController alloc] initWithActivityItems:@[yourImage]
                                          applicationActivities:@[postcardUIActivity]];
    [self presentViewController:activityViewController
                       animated:YES
                     completion:nil];


Activity Items
==============
The PostcardUIActivity will support:
*  UIImage objects
*  NSURL objects that:
   * Are File URL's
   * End with ".jpg" or ".png"

If you pass the UIActivityViewController instances of NSURL's that point to image files on the device,
the PostcardUIActivity will create UIImage objects from the files and pass the images to the 
Sincerely Controller.

So both of these objects could be passed to the UIActivityViewController and would be recognized as
supported objects.

    UIImage *image = [UIImage imageNamed@"SomeImage"];
    NSURL *imageUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"tmp/image.jpg"]
                                 isDirectory:NO];


