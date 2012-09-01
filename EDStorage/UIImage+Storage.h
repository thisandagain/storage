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

- (void)persistToCache:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToTemp:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToDocuments:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;

@end