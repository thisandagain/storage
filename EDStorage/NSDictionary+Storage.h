//
//  NSDictionary+Storage.h
//  storage
//
//  Created by Andrew Sliwinski on 12/5/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDStorageManager.h"

@interface NSDictionary (Storage)

- (void)persistToCache:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToTemp:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToDocuments:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;

@end
