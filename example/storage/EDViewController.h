//
//  EDViewController.h
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 Andrew Sliwinski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStorage.h"

@interface EDViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *sampleImage;
@property (nonatomic, retain) IBOutlet UIImageView *savedImage;

- (IBAction)saveToCache:(id)sender;
- (IBAction)saveToTemp:(id)sender;
- (IBAction)saveToDocuments:(id)sender;

@end