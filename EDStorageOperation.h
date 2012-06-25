//
//  EDStorageOperation.h
//  storage
//
//  Created by Andrew Sliwinski on 6/23/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDStorageOperation : NSOperation
{
    id dataset;
    NSURL *target;
}

@property (atomic, retain) NSURL *target;

- (id)initWithData:(id)data forURL:(NSURL *)url;

@end