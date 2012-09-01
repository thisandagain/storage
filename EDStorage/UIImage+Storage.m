//
//  UIImage+Storage.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "UIImage+Storage.h"

@implementation UIImage (Storage)

#pragma mark - Public methods

- (void)persistToCache:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:EDStorageDirectoryCache success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)persistToTemp:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:EDStorageDirectoryTemp success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)persistToDocuments:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:EDStorageDirectoryDocuments success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - Private methods

- (NSData *)jpgRepresentation
{
    return UIImageJPEGRepresentation(self, 0.8f);
}

@end