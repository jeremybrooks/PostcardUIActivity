PostcardUIActivity
==================

A UIActivity that launches the Sincerely postcard ordering process from a UIActivityViewController.

![](http://farm8.staticflickr.com/7426/10048377684_209a3a94e1.jpg)

Using In Your Project
=====================
First, you need an Application Key from Sincerely. You can get an Application Key by going to 
http://dev.sincerely.com and requesting one. Follow their instructions for adding ShipLib to
your project.

Next, download this project and drag the PostcardUIActivity folder to your application.

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



License
=======
 The MIT License (MIT)
 
 Copyright (c) 2013 Jeremy Brooks
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

