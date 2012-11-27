/*********************************************************************************
 
 © Copyright 2010, Isaac Greenspan
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 *********************************************************************************/
//  IGIsolatedCookieWebView.m

#import "IGIsolatedCookieWebView.h"
#import "NSHTTPCookie+Testing.h"
#import "SIAppCookieJar.h"

#pragma mark private resourceLoadDelegate class interface

@interface IGIsolatedCookieWebViewResourceLoadDelegate : NSObject

- (IGIsolatedCookieWebViewResourceLoadDelegate *)init;

- (NSURLREQ*)webView: (WebView*)sender resource: (id)identifier	              willSendRequest: (NSURLREQ*)request
		                       redirectResponse: (NSURLRES*)redirectResponse   fromDataSource: (WebDataSource*)dataSource;

- (void)webView:(WebView *)sender	   resource:(id)identifier	   		   didReceiveResponse: (NSURLREQ*)response
																	           fromDataSource: (WebDataSource*)dataSource;
- (NSA*) getCookieArrayForRequest: (NSURLREQ*)request;

@end

#pragma mark main class implementation

@implementation IGIsolatedCookieWebView

- (id)initWithFrame: (NSR)frame { if (!(self = [super initWithFrame:frame])) return nil;	[self awakeFromNib];	return self;	}

- (void)awakeFromNib		   	{ [self setResourceLoadDelegate:[[IGIsolatedCookieWebViewResourceLoadDelegate alloc] init]];	}

- (void)injectCookie: (NSHTTPCookie*)cookie	{	[[SIAppCookieJar sharedSIAppCookieJar] setCookie:cookie];						}

@end

#pragma mark private category on NSHTTPCookie to facilitate testing properties of the cookie

#pragma mark private resourceLoadDelegate class implementation

@implementation IGIsolatedCookieWebViewResourceLoadDelegate

- (IGIsolatedCookieWebViewResourceLoadDelegate *)init {	self = [super init]; if (self) {	} return self; } //		NSLog(@"%d %@",[(NSHTTPURLResponse *)response statusCode],[[response URL] absoluteURL]);

- (void)pullCookiesFromResponse:(NSURLResponse *)response
{
	[response respondsToSelector:@selector(allHeaderFields)] ?
	[[[NSHTTPCookie cookiesWithResponseHeaderFields:[(NSHTTPURLResponse *)response allHeaderFields] forURL:[response URL]] copy]each:^(NSHTTPCookie *aCookie) {
			[[SIAppCookieJar sharedSIAppCookieJar] setCookie:aCookie];  }] : nil;
}

- (NSURLRequest *)webView:(WebView *)sender resource:(id)identifier willSendRequest:(NSURLREQ*)request redirectResponse:(NSURLRES*)redirectResponse fromDataSource:(WebDataSource *)dataSource
{
	if (redirectResponse) [self pullCookiesFromResponse:redirectResponse];
	NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:[request URL] cachePolicy:[request cachePolicy] timeoutInterval:[request timeoutInterval]];
	[newRequest setAllHTTPHeaderFields:[request allHTTPHeaderFields]];
	[request HTTPBodyStream]	 ?
		[newRequest       setHTTPBodyStream:[request HTTPBodyStream]]:
		[newRequest    			      setHTTPBody:[request HTTPBody]];
	[newRequest 		          setHTTPMethod:[request HTTPMethod]];
	[newRequest  			           setHTTPShouldHandleCookies:NO];
	[newRequest         setMainDocumentURL:[request mainDocumentURL]];
	NSArray *newCookies 	= [self getCookieArrayForRequest:request];
	if (newCookies	&& ([newCookies count] > 0)) {
//		NSLog(@"cookies being sent to %@: %@",	[[request URL] absoluteURL],	[NSHTTPCookie requestHeaderFieldsWithCookies:newCookies]);
		NSMD *newAllHeaders = [NSMD dictionaryWithDictionary:[request allHTTPHeaderFields]];
		[newAllHeaders addEntriesFromDictionary:[NSHTTPCookie requestHeaderFieldsWithCookies:newCookies]];
		[newRequest setAllHTTPHeaderFields:[NSDictionary dictionaryWithDictionary:newAllHeaders]];
	}
	return newRequest;
}

- (void)webView:(WebView *)sender	resource:(id)identifier	didReceiveResponse:(NSURLRES*)response	fromDataSource:(WebDataSource *)dataSource
{
	[self pullCookiesFromResponse:response];
}

- (NSA*)getCookieArrayForRequest:(NSURLRequest *)request
{
	return [[[SIAppCookieJar sharedSIAppCookieJar] cookieStore] filter:^BOOL(NSHTTPCookie *aCookie) { return [aCookie isForRequest:request]; }];
}

@end