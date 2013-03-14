//
//  SIAppCookieJar.h
//  StackInbox
//
//  Created by Jonathan Bailey on 27/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AtoZ/AtoZ.h>


@interface SIAppCookieJar : BaseModel // : NSObject

@property (nonatomic, retain) NSMutableArray *cookieStore;

- (id) 				initSingleton; 				// <= add these to the interface
+ (SIAppCookieJar*) sharedSIAppCookieJar;  		// <= where Foo is the class name
- (NSS *) 		pathForCookieJar;

- (void) setCookie: (NSHTTPCookie*)cookie;
- (void) removeExpiredCookies;
- (void) removeAllCookies;

@end
