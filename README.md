## Storage
#### Persist all the things! Wheee!

In attempting to keep things [DRY](http://en.wikipedia.org/wiki/Don't_repeat_yourself), EDStorage was created to address the fair amount of boilerplate that often gets created to deal with writing data to disk within iOS applications in a performant manner. Disk I/O within iOS is syncronous and so much of this boilerplate is often written to improve performance by moving I/O to a background thread. EDStorage accomplishes this by transforming each write instance into a `NSOperation` which is managed by a single `NSOperationQueue`. All of this is done in the background while providing high-level methods to the user via categories. 

**EDStorage strives to provide three things:**
- An abstract interface based on categories that makes persisting data to disk simple.
- A highly generic management interface that makes extending EDStorage equaly simple.
- To be fast and safe.

## Basic Use
The easiest way to get going with EDStorage is to take a look at the included example application. The XCode project file can be found in `example > storage.xcodeproj`. That said, if you are more inclined to read code than pick away at a sample project (you know who you are)... read on:

YourInterface.h
```objective-c
#import <EDStorage.h>
```

YourImplementation.m
```objective-c
- (void)doSomething
{
    UIImage *image = [UIImage imageNamed:@"keyboardCat.png"];
    
    [image persistToCache:^(NSURL *url, NSUInteger size) {
        NSLog(@"FTW!: %@ | %d bytes", url, size);
        [self updateSavedImagePreview:[url path]];
    } failure:^(NSError *error) {
        NSLog(@"UH OH: %@", error);
    }];
}
```

## Implementing A Custom Category
`EDStorageManager` provides a single block method for interfacing with categories:

```objective-c
- (void)persistData:(id)data withExtension:(NSString *)ext toLocation:(Location)location success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
```

Categories simply abstract the process of calling this method on `EDStorageManager` by handling conversion of the class instance into a NSData object. For example, the storage category for UIImage simply passes self into NSData by calling `UIImageJPEGRepresentation()`. 

**If you create a category that you find useful, please let me know! I would love to add it to the project.**

---

## Locations
```objective-c
kEDStorageDirectoryCache
kEDStorageDirectoryTemp
kEDStorageDirectoryDocuments
```

## NSData+Storage Methods
```objective-c
- (void)persistToCacheWithExtension:(NSString *)extension success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToTempWithExtension:(NSString *)extension success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToDocumentsWithExtension:(NSString *)extension success:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
```

## UIImage+Storage Methods
```objective-c
- (void)persistToCache:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToTemp:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
- (void)persistToDocuments:(void (^)(NSURL *url, NSUInteger size))success failure:(void (^)(NSError *error))failure;
```

---

## iOS Support
EDStorage is tested on iOS 5 and up. Older versions of iOS may work but are not currently supported.

## ARC
If you are including EDStorage in a project that uses [Automatic Reference Counting (ARC)](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html), you will need to set the `-fno-objc-arc` compiler flag on all of the EDStorage source files. To do this in Xcode, go to your active target and select the "Build Phases" tab. Now select all EDStorage source files, press Enter, insert `-fno-objc-arc` and then "Done" to disable ARC for EDStorage.
