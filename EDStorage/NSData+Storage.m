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
    [[EDStorageManager sharedInstance] persistData:self withExtension:extension toLocation:EDStorageDirectoryCache success:(void *)([success copy]) failure:(void *)([failure copy])]; 
}

- (void)persistToTempWithExtension:(NSString *)extension success:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:self withExtension:extension toLocation:EDStorageDirectoryTemp success:(void *)([success copy]) failure:(void *)([failure copy])];
}

- (void)persistToDocumentsWithExtension:(NSString *)extension success:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{
    [[EDStorageManager sharedInstance] persistData:self withExtension:extension toLocation:EDStorageDirectoryDocuments success:(void *)([success copy]) failure:(void *)([failure copy])];
}

@end
