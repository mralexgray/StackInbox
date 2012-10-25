//
//  ASIFormDataRequest.h
//  Part of ASIHTTPRequest -> http://allseeing-i.com/ASIHTTPRequest
//
//  Created by Ben Copsey on 07/11/2008.
//  Copyright 2008-2009 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestConfig.h"

typedef enum _ASIPostFormat {
	ASIMultipartFormDataPostFormat = 0,
	ASIURLEncodedPostFormat = 1
	
} ASIPostFormat;

@interface ASIFormDataRequest : ASIHTTPRequest <NSCopying> {

	// Parameters that will be POSTed to the url
	NSMutableArray *postData;
	
	// Files that will be POSTed to the url
	NSMutableArray *fileData;
	
	ASIPostFormat postFormat;
	
	NSStringEncoding stringEncoding;
	
#if DEBUG_FORM_DATA_REQUEST
	// Will store a string version of the request body that will be printed to the console when ASIHTTPREQUEST_DEBUG is set in GCC_PREPROCESSOR_DEFINITIONS
	NSS *debugBodyString;
#endif
	
}

#pragma mark utilities 
- (NSString*)encodeURL:(NSS *)string; 
 
#pragma mark setup request

// Add a POST variable to the request
- (void)addPostValue:(id <NSObject>)value forKey:(NSS *)key;

// Set a POST variable for this request, clearing any others with the same key
- (void)setPostValue:(id <NSObject>)value forKey:(NSS *)key;

// Add the contents of a local file to the request
- (void)addFile:(NSS *)filePath forKey:(NSS *)key;

// Same as above, but you can specify the content-type and file name
- (void)addFile:(NSS *)filePath withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key;

// Add the contents of a local file to the request, clearing any others with the same key
- (void)setFile:(NSS *)filePath forKey:(NSS *)key;

// Same as above, but you can specify the content-type and file name
- (void)setFile:(NSS *)filePath withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key;

// Add the contents of an NSData object to the request
- (void)addData:(NSData *)data forKey:(NSS *)key;

// Same as above, but you can specify the content-type and file name
- (void)addData:(id)data withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key;

// Add the contents of an NSData object to the request, clearing any others with the same key
- (void)setData:(NSData *)data forKey:(NSS *)key;

// Same as above, but you can specify the content-type and file name
- (void)setData:(id)data withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key;


@property (assign) ASIPostFormat postFormat;
@property (assign) NSStringEncoding stringEncoding;
@end
