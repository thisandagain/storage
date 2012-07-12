//
//  NSData+Storage.m
//  storage
//
//  Created by Andrew Sliwinski on 6/24/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "NSData+Storage.h"

@implementation NSData (Storage)

- (void)persistToCacheWithExtension:(NSString *)extension success:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:self withExtension:extension toLocation:EDStorageDirectoryCache success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)persistToTempWithExtension:(NSString *)extension success:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:self withExtension:extension toLocation:EDStorageDirectoryTemp success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)persistToDocumentsWithExtension:(NSString *)extension success:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:self withExtension:extension toLocation:EDStorageDirectoryDocuments success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
