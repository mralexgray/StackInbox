//
//  ASIFormDataRequest.m
//  Part of ASIHTTPRequest -> http://allseeing-i.com/ASIHTTPRequest
//
//  Created by Ben Copsey on 07/11/2008.
//  Copyright 2008-2009 All-Seeing Interactive. All rights reserved.
//

#import "ASIFormDataRequest.h"


// Private stuff
@interface ASIFormDataRequest ()
- (void)buildMultipartFormDataPostBody;
- (void)buildURLEncodedPostBody;
- (void)appendPostString:(NSS *)string;

@property (strong) NSMutableArray *postData;
@property (strong) NSMutableArray *fileData;

#if DEBUG_FORM_DATA_REQUEST
- (void)addToDebugBody:(NSS *)string;
@property (retain, nonatomic) NSS *debugBodyString;
#endif

@end

@implementation ASIFormDataRequest

#pragma mark utilities
- (NSString*)encodeURL:(NSS *)string
{
	NSS *newString = (__bridge_transfer NSString*) CFURLCreateStringByAddingPercentEscapes(	NULL, (CFStringRef)self, NULL,
				(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );

//	NSS *newString = NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding([self stringEncoding])));
	if (newString) {
		return newString;
	}
	return @"";
}

#pragma mark init / dealloc

+ (id)requestWithURL:(NSURL *)newURL
{
	return [[self alloc] initWithURL:newURL];
}

- (id)initWithURL:(NSURL *)newURL
{
	self = [super initWithURL:newURL];
	[self setPostFormat:ASIURLEncodedPostFormat];
	[self setStringEncoding:NSUTF8StringEncoding];
		[self setRequestMethod:@"POST"];
	return self;
}


#pragma mark setup request

- (void)addPostValue:(id <NSObject>)value forKey:(NSS *)key
{
	if (!key) {
		return;
	}
	if (![self postData]) {
		[self setPostData:[NSMutableArray array]];
	}
	NSMD *keyValuePair = [NSMD dictionaryWithCapacity:2];
	[keyValuePair setValue:key forKey:@"key"];
	[keyValuePair setValue:[value description] forKey:@"value"];
	[[self postData] addObject:keyValuePair];
}

- (void)setPostValue:(id <NSObject>)value forKey:(NSS *)key
{
	// Remove any existing value
	NSUInteger i;
	for (i=0; i<[[self postData] count]; i++) {
		NSDictionary *val = [self postData][i];
		if ([val[@"key"] isEqualToString:key]) {
			[[self postData] removeObjectAtIndex:i];
			i--;
		}
	}
	[self addPostValue:value forKey:key];
}


- (void)addFile:(NSS *)filePath forKey:(NSS *)key
{
	[self addFile:filePath withFileName:nil andContentType:nil forKey:key];
}

- (void)addFile:(NSS *)filePath withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key
{
	BOOL isDirectory = NO;
	BOOL fileExists = [[[NSFileManager alloc] init] fileExistsAtPath:filePath isDirectory:&isDirectory];
	if (!fileExists || isDirectory) {
		[self failWithError:[NSError errorWithDomain:NetworkRequestErrorDomain code:ASIInternalErrorWhileBuildingRequestType userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"No file exists at %@",filePath]}]];
	}

	// If the caller didn't specify a custom file name, we'll use the file name of the file we were passed
	if (!fileName) {
		fileName = [filePath lastPathComponent];
	}

	// If we were given the path to a file, and the user didn't specify a mime type, we can detect it from the file extension
	if (!contentType) {
		contentType = [ASIHTTPRequest mimeTypeForFileAtPath:filePath];
	}
	[self addData:filePath withFileName:fileName andContentType:contentType forKey:key];
}

- (void)setFile:(NSS *)filePath forKey:(NSS *)key
{
	[self setFile:filePath withFileName:nil andContentType:nil forKey:key];
}

- (void)setFile:(id)data withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key
{
	// Remove any existing value
	NSUInteger i;
	for (i=0; i<[[self fileData] count]; i++) {
		NSDictionary *val = [self fileData][i];
		if ([val[@"key"] isEqualToString:key]) {
			[[self fileData] removeObjectAtIndex:i];
			i--;
		}
	}
	[self addFile:data withFileName:fileName andContentType:contentType forKey:key];
}

- (void)addData:(NSData *)data forKey:(NSS *)key
{
	[self addData:data withFileName:@"file" andContentType:nil forKey:key];
}

- (void)addData:(id)data withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key
{
	if (![self fileData]) {
		[self setFileData:[NSMutableArray array]];
	}
	if (!contentType) {
		contentType = @"application/octet-stream";
	}

	NSMD *fileInfo = [NSMD dictionaryWithCapacity:4];
	[fileInfo setValue:key forKey:@"key"];
	[fileInfo setValue:fileName forKey:@"fileName"];
	[fileInfo setValue:contentType forKey:@"contentType"];
	[fileInfo setValue:data forKey:@"data"];

	[[self fileData] addObject:fileInfo];
}

- (void)setData:(NSData *)data forKey:(NSS *)key
{
	[self setData:data withFileName:@"file" andContentType:nil forKey:key];
}

- (void)setData:(id)data withFileName:(NSS *)fileName andContentType:(NSS *)contentType forKey:(NSS *)key
{
	// Remove any existing value
	NSUInteger i;
	for (i=0; i<[[self fileData] count]; i++) {
		NSDictionary *val = [self fileData][i];
		if ([val[@"key"] isEqualToString:key]) {
			[[self fileData] removeObjectAtIndex:i];
			i--;
		}
	}
	[self addData:data withFileName:fileName andContentType:contentType forKey:key];
}

- (void)buildPostBody
{
	if ([self haveBuiltPostBody]) {
		return;
	}
	
#if DEBUG_FORM_DATA_REQUEST
	[self setDebugBodyString:@""];	
#endif
	
	if (![self postData] && ![self fileData]) {
		[super buildPostBody];
		return;
	}	
	if ([[self fileData] count] > 0) {
		[self setShouldStreamPostDataFromDisk:YES];
	}
	
	if ([self postFormat] == ASIURLEncodedPostFormat) {
		[self buildURLEncodedPostBody];
	} else {
		[self buildMultipartFormDataPostBody];
	}

	[super buildPostBody];
	
#if DEBUG_FORM_DATA_REQUEST
	ASI_DEBUG_LOG(@"%@",[self debugBodyString]);
	[self setDebugBodyString:nil];
#endif
}


- (void)buildMultipartFormDataPostBody
{
#if DEBUG_FORM_DATA_REQUEST
	[self addToDebugBody:@"\r\n==== Building a multipart/form-data body ====\r\n"];
#endif
	
	NSS *charset = (NSS *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding([self stringEncoding]));
	
	// We don't bother to check if post data contains the boundary, since it's pretty unlikely that it does.
	CFUUIDRef uuid = CFUUIDCreate(nil);
	NSS *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuid));
	CFRelease(uuid);
	NSS *stringBoundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];
	
	[self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"multipart/form-data; charset=%@; boundary=%@", charset, stringBoundary]];
	
	[self appendPostString:[NSString stringWithFormat:@"--%@\r\n",stringBoundary]];
	
	// Adds post data
	NSS *endItemBoundary = [NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
	NSUInteger i=0;
	for (NSDictionary *val in [self postData]) {
		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",val[@"key"]]];
		[self appendPostString:val[@"value"]];
		i++;
		if (i != [[self postData] count] || [[self fileData] count] > 0) { //Only add the boundary if this is not the last item in the post body
			[self appendPostString:endItemBoundary];
		}
	}
	
	// Adds files to upload
	i=0;
	for (NSDictionary *val in [self fileData]) {

		[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", val[@"key"], val[@"fileName"]]];
		[self appendPostString:[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", val[@"contentType"]]];
		
		id data = val[@"data"];
		if ([data isKindOfClass:[NSString class]]) {
			[self appendPostDataFromFile:data];
		} else {
			[self appendPostData:data];
		}
		i++;
		// Only add the boundary if this is not the last item in the post body
		if (i != [[self fileData] count]) { 
			[self appendPostString:endItemBoundary];
		}
	}
	
	[self appendPostString:[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary]];
	
#if DEBUG_FORM_DATA_REQUEST
	[self addToDebugBody:@"==== End of multipart/form-data body ====\r\n"];
#endif
}

- (void)buildURLEncodedPostBody
{

	// We can't post binary data using application/x-www-form-urlencoded
	if ([[self fileData] count] > 0) {
		[self setPostFormat:ASIMultipartFormDataPostFormat];
		[self buildMultipartFormDataPostBody];
		return;
	}
	
#if DEBUG_FORM_DATA_REQUEST
	[self addToDebugBody:@"\r\n==== Building an application/x-www-form-urlencoded body ====\r\n"]; 
#endif
	
	
	NSS *charset = (NSS *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding([self stringEncoding]));

	[self addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset]];

	
	NSUInteger i=0;
	NSUInteger count = [[self postData] count]-1;
	for (NSDictionary *val in [self postData]) {
		NSS *data = [NSString stringWithFormat:@"%@=%@%@", [self encodeURL:val[@"key"]], [self encodeURL:val[@"value"]],(i<count ?  @"&" : @"")]; 
		[self appendPostString:data];
		i++;
	}
#if DEBUG_FORM_DATA_REQUEST
	[self addToDebugBody:@"\r\n==== End of application/x-www-form-urlencoded body ====\r\n"]; 
#endif
}

- (void)appendPostString:(NSS *)string
{
#if DEBUG_FORM_DATA_REQUEST
	[self addToDebugBody:string];
#endif
	[super appendPostData:[string dataUsingEncoding:[self stringEncoding]]];
}

#if DEBUG_FORM_DATA_REQUEST
- (void)appendPostData:(NSData *)data
{
	[self addToDebugBody:[NSString stringWithFormat:@"[%lu bytes of data]",(unsigned long)[data length]]];
	[super appendPostData:data];
}

- (void)appendPostDataFromFile:(NSS *)file
{
	NSError *err = nil;
	unsigned long long fileSize = [[[[[[NSFileManager alloc] init] autorelease] attributesOfItemAtPath:file error:&err] objectForKey:NSFileSize] unsignedLongLongValue];
	if (err) {
		[self addToDebugBody:[NSString stringWithFormat:@"[Error: Failed to obtain the size of the file at '%@']",file]];
	} else {
		[self addToDebugBody:[NSString stringWithFormat:@"[%llu bytes of data from file '%@']",fileSize,file]];
	}

	[super appendPostDataFromFile:file];
}

- (void)addToDebugBody:(NSS *)string
{
	if (string) {
		[self setDebugBodyString:[[self debugBodyString] stringByAppendingString:string]];
	}
}
#endif

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone
{
	ASIFormDataRequest *newRequest = [super copyWithZone:zone];
	[newRequest setPostData:[[self postData] mutableCopyWithZone:zone]];
	[newRequest setFileData:[[self fileData] mutableCopyWithZone:zone]];
	[newRequest setPostFormat:[self postFormat]];
	[newRequest setStringEncoding:[self stringEncoding]];
	[newRequest setRequestMethod:[self requestMethod]];
	return newRequest;
}

@synthesize postData;
@synthesize fileData;
@synthesize postFormat;
@synthesize stringEncoding;
#if DEBUG_FORM_DATA_REQUEST
@synthesize debugBodyString;
#endif
@end
