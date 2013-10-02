/*
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
 */

#import "PostcardUIActivity.h"

@implementation PostcardUIActivity

/*
 * Use this method to initialize the PostcardUIActivity with your Application Key.
 *
 * If you need an application key, go to http://dev.sincerely.com
 */
-(id)initWithApplicationKey:(NSString *)applicationKey
{
    self = [super init];
    if (self) {
        self.applicationKey = applicationKey;
        self.images = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - UIActivity Methods
-(NSString *) activityType
{
    return @"postcard";
}

-(NSString *) activityTitle
{
    return @"Send Postcard";
}


-(UIImage *) activityImage
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return [UIImage imageNamed:@"PostcardUIActivity7"];
    } else {
        return [UIImage imageNamed:@"PostcardUIActivity"];
    }
    
}


/*
 * Tell the UIActivityController that we can handle:
 *  - UIImage objects
 *  - NSURL objects that:
 *      - Point to a file
 *      - end with "jpg" or "png"
 */
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    BOOL canPerform = NO;
    for (id object in activityItems) {
        if ([object isKindOfClass:[UIImage class]]) {
            canPerform = YES;
        } else if ([object isKindOfClass:[NSURL class]]) {
            NSURL *url  = (NSURL *) object;
            if ([url isFileURL] && ([url.lastPathComponent hasSuffix:@".jpg"] || [url.lastPathComponent hasSuffix:@".png"]) ) {
                canPerform = YES;
            }
        }
    }
    return canPerform;
}


/*
 * Called after the user has selected this service, but before the service is asked to perform any action.
 *
 * We save any UIImages that are passed in, and load images from file URL's that are passed in.
 */
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id object in activityItems) {
        if ([object isKindOfClass:[UIImage class]]) {
            [self.images addObject:object];
        } else if ([object isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL *) object;
            if ([url isFileURL] && ([url.lastPathComponent hasSuffix:@".jpg"] || [url.lastPathComponent hasSuffix:@".png"]) ) {
                NSData *imgData = [NSData dataWithContentsOfURL:url];
                [self.images addObject:[UIImage imageWithData:imgData]];
            }
        }
        
    }
}


+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryAction;
}


/*
 * We use this method to handle a user selecting the Send Postcard activity.
 *
 * The Sincerely Controller is passed to the UIActivityController and automatically displayed and dismissed.
 */
- (UIViewController *)activityViewController
{
    return [[SYSincerelyController alloc] initWithImages:self.images
                                                 product:SYProductTypePostcard
                                          applicationKey:self.applicationKey
                                                delegate:self];
}


#pragma mark - SincerelyController delegate methods

-(void)sincerelyControllerDidCancel:(SYSincerelyController *)controller
{
    [self activityDidFinish:YES];
}

-(void)sincerelyControllerDidFailInitiationWithError:(NSError *)error
{
    NSLog(@"ERROR %@", error);
    [self activityDidFinish:NO];
}

-(void)sincerelyControllerDidFinish:(SYSincerelyController *)controller
{
    [self activityDidFinish:YES];
}

@end
