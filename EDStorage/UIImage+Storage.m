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
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:EDStorageDirectoryTemp success:(void *)([success copy]) failure:(void *)([failure copy])];
}

- (void)persistToTemp:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:EDStorageDirectoryTemp success:(void *)([success copy]) failure:(void *)([failure copy])];
}

- (void)persistToDocuments:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:[self jpgRepresentation] withExtension:@"jpg" toLocation:EDStorageDirectoryDocuments success:(void *)([success copy]) failure:(void *)([failure copy])];
}

#pragma mark - Private methods

- (NSData *)jpgRepresentation
{
    return UIImageJPEGRepresentation(self, 0.8f);
}

@end