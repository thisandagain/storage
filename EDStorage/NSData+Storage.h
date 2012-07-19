//
//  NSData+Storage.h
//  storage
//
//  Created by Andrew Sliwinski on 6/24/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDStorageManager.h"

@interface NSData (Storage)

- (void)persistToCacheWithExtension:(NSString *)extension success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToTempWithExtension:(NSString *)extension success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToDocumentsWithExtension:(NSString *)extension success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;

@end