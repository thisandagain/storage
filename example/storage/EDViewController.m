//
//  EDViewController.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 Andrew Sliwinski. All rights reserved.
//

#import "EDViewController.h"

@implementation EDViewController

@synthesize sampleImage = _sampleImage;
@synthesize savedImage = _savedImage;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //
    
    UIImage *image  = [UIImage imageNamed:@"nayn.png"];
    NSData *data    = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
    [data persistToDocumentsWithExtension:@"png" success:^(NSURL *url, NSUInteger size) {
        NSLog(@"Complete: %@ | %d", url, size);
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UI events

- (IBAction)saveToCache:(id)sender
{    
    [self.sampleImage.image persistToCache:^(NSURL *url, NSUInteger size) {
        NSLog(@"Complete: %@ | %d", url, size);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)saveToTemp:(id)sender
{
    [self.sampleImage.image persistToTemp:^(NSURL *url, NSUInteger size) {
        NSLog(@"Complete: %@ | %d", url, size);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (IBAction)saveToDocuments:(id)sender
{
    [self.sampleImage.image persistToDocuments:^(NSURL *url, NSUInteger size) {
        NSLog(@"Complete: %@ | %d", url, size);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Render

- (void)updateSavedImagePreview:(NSString *)relativePath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        UIImage *image = [UIImage imageWithContentsOfFile:relativePath];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.savedImage.image = image;
        });
        
    });
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    _sampleImage = nil;
    _savedImage = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self releaseObjects];
}

- (void)dealloc
{
    [self releaseObjects];
}

@end
