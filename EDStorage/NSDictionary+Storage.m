//
//  NSDictionary+Storage.m
//  storage
//
//  Created by Andrew Sliwinski on 12/5/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "NSDictionary+Storage.h"

@implementation NSDictionary (Storage)

#pragma mark - Public methods

- (void)persistToCache:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self representation] withExtension:@"plist" toLocation:EDStorageDirectoryTemp success:(void *)([success copy]) failure:(void *)([failure copy])];
}

- (void)persistToTemp:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self representation] withExtension:@"plist" toLocation:EDStorageDirectoryTemp success:(void *)([success copy]) failure:(void *)([failure copy])];
}

- (void)persistToDocuments:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self representation] withExtension:@"plist" toLocation:EDStorageDirectoryDocuments success:(void *)([success copy]) failure:(void *)([failure copy])];
}

#pragma mark - Private methods

- (NSData *)representation
{
    return [[self description] dataUsingEncoding:NSUTF16StringEncoding];
}

@end