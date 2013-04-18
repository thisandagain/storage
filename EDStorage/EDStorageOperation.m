//
//  EDStorageOperation.m
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "EDStorageOperation.h"

@implementation EDStorageOperation

@synthesize target = _target;
@synthesize size = _size;
@synthesize complete = _complete;
@synthesize error = _error;

#pragma mark - Init

- (id)initWithData:(id)data forURL:(NSURL *)url
{
    self = [super init];
    if (!self) return nil;
    
    dataset    = data;
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
    @autoreleasepool {
        NSError *err;
        self.complete = [dataset writeToURL:self.target options:NSDataWritingAtomic error:&err];
        if (err) {
            _error = err;
        }
    }
}

#pragma mark - Dealloc

- (void)dealloc
{    
    dataset = nil;
    
    _target = nil;
    _error = nil;
}

@end