//
//  UIImage+Storage.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <objc/runtime.h>
#import "UIImage+Storage.h"

NSString * const kEDJpgQualityKey = @"kEDJpgQualityKey";

@implementation UIImage (Storage)
@dynamic jpgQuality;

#pragma mark - Associative reference

- (void)setJpgQuality:(NSNumber *)jpgQuality
{
    objc_setAssociatedObject(self, kEDJpgQualityKey, jpgQuality, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)jpgQuality
{
    NSNumber *a = objc_getAssociatedObject(self, kEDJpgQualityKey);
    if (a == nil) a = [NSNumber numberWithFloat:1.0f];
    
    return a;
}

#pragma mark - Public methods

- (void)persistToCache:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:kEDStorageDirectoryCache success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)persistToTemp:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:kEDStorageDirectoryTemp success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)persistToDocuments:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:kEDStorageDirectoryDocuments success:^(NSURL *url, NSUInteger size) {
        success(url, size);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - Private methods

- (NSData *)jpgRepresentation
{
    return UIImageJPEGRepresentation(self, [[self jpgQuality] floatValue]);
}

#pragma mark - Dealloc

- (void)dealloc
{
    [super dealloc];
}

@end