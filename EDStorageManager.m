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

@synthesize queue;

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
        NSOperationQueue *tQueue = [[NSOperationQueue alloc] init];
        self.queue = tQueue;
        self.queue.maxConcurrentOperationCount = 2;
        
        //
        
        [tQueue release];
    }
    return self;
}

#pragma mark - Public methods

- (void)persistData:(id)data withExtension:(NSString *)ext toLocation:(NSString *)location success:(void (^)(NSURL *))success failure:(void (^)(NSException *))failure
{       
    // Storage object
    NSURL *url = nil;
    
    // Parse location
    if ([location isEqualToString:@"cache"])
    {
        url = [self createAssetFileURL:0 withExtension:ext];
    } else if ([location isEqualToString:@"temp"]) {
        url = [self createAssetFileURL:1 withExtension:ext];
    } else {
        failure([NSException exceptionWithName:@"Invalid URL" reason:@"The location provided was not a valid type." userInfo:nil]);
    }
    
    // Perform operation
    EDStorageOperation *operation = [[EDStorageOperation alloc] initWithData:data forURL:url];
    [operation setCompletionBlock:^{
        // @note Handle errors & exceptions here...
        success(operation.target);
                
        //
        
        [operation setCompletionBlock:nil];     // Force dealloc
    }];
    [queue addOperation:operation];
    [operation release];
}

#pragma mark - Private methods

/**
 * Creates an asset file url (path) using type declaration and file extension.
 *
 * @param {int} Type (0 - NSTemporaryDirectory() | 1 - NSCachesDirectory)
 * @param {NSString} Extension (e.g. @"jpg")
 *
 * @return {NSURL}
 */
- (NSURL *)createAssetFileURL:(int)type withExtension:(NSString *)extension
{
    NSArray *paths = nil;
    NSString *documentsDirectory = nil;
    
    switch (type) {
        case 0:
            paths                   = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            documentsDirectory      = [paths objectAtIndex:0];
            break;
        default:
            documentsDirectory      = NSTemporaryDirectory();
            break;
    }
    
    NSString *assetName             = [NSString stringWithFormat:@"%@.%@", [[NSProcessInfo processInfo] globallyUniqueString], extension];
    NSString *assetPath             = [documentsDirectory stringByAppendingPathComponent:assetName];
    
    return [NSURL fileURLWithPath:assetPath];
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    [queue release]; queue = nil;
}

- (void)dealloc
{
    [self releaseObjects];
    [super dealloc];
}

@end