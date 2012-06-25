//
//  EDViewController.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 Andrew Sliwinski. All rights reserved.
//

#import "EDViewController.h"

@implementation EDViewController

@synthesize sampleImage;
@synthesize savedImage;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UI events

- (IBAction)saveToCache:(id)sender
{    
    [sampleImage.image persistToCache:^(NSURL *url) {
        NSLog(@"URL: %@", url);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }];
}

- (IBAction)saveToTemp:(id)sender
{
    [sampleImage.image persistToTemp:^(NSURL *url) {
        NSLog(@"URL: %@", url);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }];
    
    
}

- (IBAction)saveToDocuments:(id)sender
{
    [sampleImage.image persistToDocuments:^(NSURL *url) {
        NSLog(@"URL: %@", url);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }];
}

#pragma mark - Render

- (void)updateSavedImagePreview:(NSString *)relativePath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        UIImage *image = [UIImage imageWithContentsOfFile:relativePath];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            savedImage.image = image;
        });
        
    });
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    [sampleImage release]; sampleImage = nil;
    [savedImage release]; savedImage = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self releaseObjects];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self releaseObjects];
}

- (void)dealloc
{
    [self releaseObjects];
    [super dealloc];
}

@end
