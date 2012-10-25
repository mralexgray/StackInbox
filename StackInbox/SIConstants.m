//
//  SIConstants.m
//  StackInbox
//
//  Created by Jonathan Bailey on 19/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SIConstants.h"

NSS * const SIAuthWindowShown 	= @"SIAuthWindowShown"								;
NSS * const SIAuthWindowClosed = @"SIAuthWindowClosed"								;
NSS * const SIAuthSuccessful 	= @"SIAuthSuccessful"								;
NSS * const ClientID 			= @"23"												;
NSS * const RedirectURI 		= @"https://stackexchange.com/oauth/login_success"	;

NSString* appPath()
{
	NSFileManager *fileManager 		= [NSFileManager defaultManager];
	NSS *folder 				= [@"~/Library/Application Support/StackInbox/" stringByExpandingTildeInPath];
	if ( [fileManager fileExistsAtPath:folder] == NO ) [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
	return [folder stringByAppendingPathComponent: @"cache"]; 
}