//
//  EGOCache.h
//  enormego
//
//  Created by Shaun Harrison on 7/4/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>


@interface EGOCache : NSObject {
@private
	NSMD* cacheDictionary;
	NSOperationQueue* diskOperationQueue;
	NSTimeInterval defaultTimeoutInterval;
}

+ (EGOCache*)currentCache;

- (void)clearCache;
- (void)removeCacheForKey: (NSS*)key;

- (BOOL)hasCacheForKey: (NSS*)key;

- (NSData*)dataForKey: (NSS*)key;
- (void)setData:(NSData*)data forKey: (NSS*)key;
- (void)setData:(NSData*)data forKey: (NSS*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSString*)stringForKey: (NSS*)key;
- (void)setString: (NSS*)aString forKey: (NSS*)key;
- (void)setString: (NSS*)aString forKey: (NSS*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

#if TARGET_OS_IPHONE
- (UIImage*)imageForKey: (NSS*)key;
- (void)setImage:(UIImage*)anImage forKey: (NSS*)key;
- (void)setImage:(UIImage*)anImage forKey: (NSS*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
#else
- (NSImage*)imageForKey: (NSS*)key;
- (void)setImage:(NSImage*)anImage forKey: (NSS*)key;
- (void)setImage:(NSImage*)anImage forKey: (NSS*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;
#endif

- (NSData*)plistForKey: (NSS*)key;
- (void)setPlist:(id)plistObject forKey: (NSS*)key;
- (void)setPlist:(id)plistObject forKey: (NSS*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (void)copyFilePath: (NSS*)filePath asKey: (NSS*)key;
- (void)copyFilePath: (NSS*)filePath asKey: (NSS*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;	

@property(nonatomic,assign) NSTimeInterval defaultTimeoutInterval; // Default is 1 day
@end