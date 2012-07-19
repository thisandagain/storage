//
//  EDStorageOperation.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "EDStorageOperation.h"

@implementation EDStorageOperation

@synthesize target  = _target;
@synthesize size = _size;
@synthesize complete = _complete;
@synthesize error = _error;

#pragma mark - Init

- (id)initWithData:(id)data forURL:(NSURL *)url
{
    if (![super init]) return nil;
    
    dataset     = [data retain];
    _size       = [dataset length];
    _complete   = false;
    
    _target     = [[NSURL alloc] init];
    self.target = url;
    
    _error      = [[NSError alloc] init];
    self.error  = NULL;
    
    return self;
}

#pragma mark - Inherit

- (void)main
{
    @try 
    {        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        self.complete = [dataset writeToURL:self.target options:NSDataWritingAtomic error:&_error];
        [pool release];
    } @catch (NSException *exception) {
        [exception raise];
    }
}

#pragma mark - Dealloc

- (void)dealloc
{    
    [dataset release]; dataset = nil;
    [_target release]; _target = nil;
    [_error release]; _error = nil;
    
    [super dealloc];
}

@end