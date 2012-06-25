//
//  EDStorageManager.h
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDStorageOperation.h"

//

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

//

@interface EDStorageManager : NSObject
{
    @private NSOperationQueue *queue;
}

+ (EDStorageManager *)sharedInstance;
- (void)persistData:(id)data withExtension:(NSString *)ext toLocation:(NSString *)location success:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;

@end