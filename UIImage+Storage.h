//
//  UIImage+Storage.h
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStorageManager.h"

@interface UIImage (Storage)

- (void)persistToCache:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;
- (void)persistToTemp:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;
- (void)persistToDocuments:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;

@property (nonatomic, retain) NSNumber *jpgQuality;

@end