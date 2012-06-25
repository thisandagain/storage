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
@synthesize size;
@synthesize complete;
@synthesize error;

#pragma mark - Init

- (id)initWithData:(id)data forURL:(NSURL *)url
{
    if (![super init]) return nil;
    
    dataset         = [data retain];
    self.target     = url;
    self.size       = [dataset length];
    self.complete   = false;
    self.error      = NULL;
    
    return self;
}

#pragma mark - Inherit

- (void)main
{
    @try 
    {        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        self.complete = [dataset writeToURL:target options:NSDataWritingAtomic error:&error];
        [pool release];
    } @catch (NSException *exception) {
        [exception raise];
    }
}

#pragma mark - Dealloc

- (void)dealloc
{    
    [dataset release]; dataset = nil;
    [target release]; target = nil;
    [error release]; error = NULL;
    
    [super dealloc];
}

@end