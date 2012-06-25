## Storage
#### Persist all the things! Wheee!

In keeping things [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself), EDStorage was created to address the fair amount of boilerplate that often gets created to deal with writing data to disk within iOS applications in a performant manner. Disk I/O within iOS is syncronous and so much of this boilerplate is often written to improve performance by moving I/O to a background thread. EDStorage accomplishes this by transforming all write instances into `NSOperations` which are managed by a singleton class that includes a `NSOperationQueue`. All of this is done in the background while providing high-level methods to the user via categories. 

EDStorage strives to provide three things:
- An abstract interface based on categories that makes persisting data to disk simple.
- A highly generic management interface that makes extending EDStorage equaly simple.
- To be fast and safe.

## Basic Use
The easiest way to get going with EDStorage is to take a look at the included example application. The XCode project file can be found in `example > storage.xcodeproj`. That said, if you are more inclined to read instructions than pick away at sample code (you know who you are)... read on:

YourInterface.h
```objective-c
#import <EDStorage.h>
```

YourImplementation.m
```objective-c
- (void)doSomething
{
    UIImage *image      = [UIImage imageNamed:@"keyboardCat.png"];
    
    [image persistToDocuments:^(NSURL *url, NSUInteger size) {
        NSLog(@"WIN! %@ | %d bytes", url, size);
    } failure:^(NSException *exception) {
        NSLog(@"UH OH! %@", exception);
    }];
}
```

## Implementing A Custom Category
`EDStorageManager` provides a single block method for interfacing with categories. 

If you create a category that you find useful, please let me know! I would love to add it to the project.

---

## Included Categories
```objective-c
NSData+Storage.h
UIImage+Storage.h
UIView+Storage.h
```

## Methods
```objective-c
- (void)persistToCache:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;
- (void)persistToTemp:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;
- (void)persistToDocuments:(void (^)(NSURL *url))success failure:(void (^)(NSException *exception))failure;
```

---

## iOS Support
EDStorage is tested on iOS 5.0.1 and up. Older versions of iOS may work but are not supported.

## ARC
ARC is not supported at this time. It is most certainly on the big 'ol "to-do" list though.