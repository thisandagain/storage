//
//  EDStorageOperation.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "EDStorageOperation.h"

@implementation EDStorageOperation

@synthesize target;

#pragma mark - Init

- (id)initWithData:(id)data forURL:(NSURL *)url
{
    if (![super init]) return nil;
    
    dataset         = [data retain];
    self.target     = url;
    
    return self;
}

#pragma mark - Inherit

- (void)main
{
    @try 
    {        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        NSError *error;
        [dataset writeToURL:target options:NSDataWritingAtomic error:&error];
        
        [pool release];
    } @catch (NSException *exception) {
        NSLog(@"EDStorageOperation: Caught %@: %@", [exception name], [exception reason]);
    }
}

#pragma mark - Dealloc

- (void)dealloc
{    
    [dataset release]; dataset = nil;
    [target release]; target = nil;
    
    [super dealloc];
}

@end