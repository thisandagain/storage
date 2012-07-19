//
//  EDStorageManager.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "EDStorageManager.h"

//

@interface EDStorageManager ()
@property (nonatomic, retain) NSOperationQueue *queue;
@end

//

@implementation EDStorageManager

@synthesize queue = _queue;

#pragma mark - Init

+ (EDStorageManager *)sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 2;
    }
    return self;
}

#pragma mark - Public methods

/**
 * Generic persistence adapter for category extensions.
 *
 * @param {id} Data
 * @param {NSString} File extension (e.g. @"jpg")
 * @param {Location} File location (see interface for enum)
 * @param {block} Success block
 * @param {block} Failure block
 *
 * @return {void}
 */
- (void)persistData:(id)data withExtension:(NSString *)ext toLocation:(Location)location success:(void (^)(NSURL *, NSUInteger))success failure:(void (^)(NSError *))failure
{       
    // Create URL
    NSURL *url = [self createAssetFileURLForLocation:location withExtension:ext];
    
    // Perform operation
    EDStorageOperation *operation = [[EDStorageOperation alloc] initWithData:data forURL:url];
    [operation setCompletionBlock:^{
        if (operation.complete)
        {
            success(operation.target, operation.size);
        } else {
            if (operation.error != NULL)
            {
                failure(operation.error);
            } else {
                failure([NSError errorWithDomain:@"com.ed.storage" code:100 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:operation, @"operation", url, @"url", nil]]);
            }
        }
        
        //
        
        [operation setCompletionBlock:nil];     // Force dealloc
    }];
    [self.queue addOperation:operation];
    [operation release];
}

#pragma mark - Private methods

/**
 * Creates an asset file url (path) using location declaration and file extension.
 *
 * @param {Location} ENUM type
 * @param {NSString} Extension (e.g. @"jpg")
 *
 * @return {NSURL}
 */
- (NSURL *)createAssetFileURLForLocation:(Location)location withExtension:(NSString *)extension
{
    NSArray *paths          = nil;
    NSString *directory     = nil;
    
    switch (location) {
        case EDStorageDirectoryCache:
            paths           = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            directory       = [paths objectAtIndex:0];
            break;
        case EDStorageDirectoryTemp:
            directory       = NSTemporaryDirectory();
            break;
        case EDStorageDirectoryDocuments:
            paths           = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            directory       = [paths objectAtIndex:0];
            break;
        default:
            [NSException raise:@"Invalid location value" format:@"Location %@ is invalid", location];
            break;
    }
    
    NSString *assetName     = [NSString stringWithFormat:@"%@.%@", [[NSProcessInfo processInfo] globallyUniqueString], extension];
    NSString *assetPath     = [directory stringByAppendingPathComponent:assetName];
    
    return [NSURL fileURLWithPath:assetPath];
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    [_queue release]; _queue = nil;
}

- (void)dealloc
{
    [self releaseObjects];
    [super dealloc];
}

@end