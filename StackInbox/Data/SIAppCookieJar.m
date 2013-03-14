//
//  SIAppCookieJar.m
//  StackInbox
//
//  Created by Jonathan Bailey on 27/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SIAppCookieJar.h"
#import "CKSingleton.h"
#import "NSHTTPCookie+Testing.h"

@implementation SIAppCookieJar
@synthesize cookieStore;
//SYNTHESIZE_SINGLETON_FOR_CLASS(SIAppCookieJar, sharedSIAppCookieJar);
//$singleton(SIAppCookieJar);


+ (instancetype) sharedSIAppCookieJar
{
	return [self sharedInstance];
}
//- (id)initSingleton {

- (void) setUp {
	cookieStore = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self pathForCookieJar]] retain];
	if (cookieStore == nil) {
		cookieStore = [[NSMutableArray arrayWithCapacity:0] retain];
	}
//	return self;
}

- (NSS *) pathForCookieJar
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSS *folder = [[NSBundle applicationSupportFolder]withPath:@"vageen"];		//AZPROCNAME [@"~/Library/Application Support/StackInbox/" stringByExpandingTildeInPath];
	if ([fileManager fileExistsAtPath: folder] == NO)
		[fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
	return [folder stringByAppendingPathComponent: @"cookies"];
}


- (void)syncCookieJar {
	if (![NSKeyedArchiver archiveRootObject:cookieStore toFile:[self pathForCookieJar]])
		NSLog(@"Error saving cookies");
}
- (void)removeExpiredCookies
{
	NSMutableArray *copyOfCookieStore = [cookieStore copy];
	for (NSHTTPCookie *aCookie in copyOfCookieStore) if ([aCookie isExpired]) 	[cookieStore removeObject:aCookie];
	[copyOfCookieStore release];
	[self syncCookieJar];
}

- (void)setCookie:(NSHTTPCookie *)cookie
{
	NSLog(@"should be setting cookie with name '%@' and value '%@' for //* URL *// domain '%@'",
			[cookie name], [cookie value], cookie.domain);//[url absoluteString]);
	if (cookie) {
		[cookieStore removeObject:cookie];
		[cookieStore addObject:cookie];
	}
	[self removeExpiredCookies];
}
- (void)removeAllCookies
{
	[self.cookieStore removeAllObjects];
	[self syncCookieJar];
}

@end
