//
//  SIInboxDownloader.m
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SIInboxDownloader.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "SIInboxModel.h"

@implementation SIInboxDownloader
@synthesize json, delegate, lastDownload;

- (void)startDownloadWithAccessToken:(NSS *)accessToken
{
#warning This is StackInbox's key, if you use this code for another app you need to use your own key

	NSS *key = @"PMk2uCNoN*jdo8tdz2nwCg((";		NSS *filter = @")w_hKtV2*GAyeu2mT7_";

	if (!accessToken || [accessToken length] == 0) {		[AZNOTCENTER postNotificationName:@"SINeedsAccessToken" object:self];	return;	}

	if ([self canStartDownload] == NO) {
//		NSNumber *nowTI 	= @([[NSDate date] timeIntervalSince1970]);  NSNumber *thenTI 	= @(self.lastDownload);
		[self.delegate downloadNotStarted:60 - ( [[NSDate date] timeIntervalSince1970] - self.lastDownload )];
		return;
	}
	[AZNOTCENTER postNotificationName:@"SIStartDownload" object:nil];
	NSS *url = $(@"https://api.stackexchange.com/2.0/inbox?key=%@&filter=%@&access_token=%@", key, filter, accessToken);
	NSLog(@"url %@", url);
	[AZNOTCENTER postNotificationName:@"SIStartedDownloading" object:self];
	
	ASIHTTPRequest *requester = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
	[requester setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
		[self.delegate updateProgressWithDecimalPercent:size/total * 100]; 
	}];
	[requester setCompletionBlock:^{
		NSS 	*responseString 	= [requester responseString].copy;
		NSError *requestError 		= [requester error].copy;
		NSMD 	*jsonDictionary 	= [[responseString objectFromJSONString]mutableCopy];
		if (requestError != nil) {
			int errorID = [jsonDictionary[@"error_id"] intValue];
			if (errorID == 401 || errorID == 402 || errorID == 403 || errorID == 406) {
				[AZNOTCENTER postNotificationName:@"SINeedsAccessToken" object:self];
			} else if (errorID) {	NSLog(@"API Error recieved: %i", errorID);
			} else 					[[NSAlert alertWithError:requestError]runModal];

		} else {		  	NSLog(@"success");
			if (jsonDictionary[@"error_id"]) {
				int errorID = [jsonDictionary[@"error_id"] intValue];
				if (errorID == 401 || errorID == 402 || errorID == 403 || errorID == 406) {
							[AZNOTCENTER postNotificationName:@"SINeedsAccessToken" object:self];
				} else		NSLog(@"API Error recieved: %i", errorID);
			} else {

				jsonDictionary[@"items"] = [(NSA*)[jsonDictionary[@"items"] copy] map:^id(NSD *itemDict) {
					return [SIInboxModel inboxItemUsingDictionary:itemDict];
				}];
				[self.delegate finishedDownloadingJSON:jsonDictionary];
			}
		}

	}];
	[requester startAsynchronous];
	self.lastDownload 	= [[NSDate date] timeIntervalSince1970];
}

- (BOOL)canStartDownload
{
	NSTimeInterval now 	= [[NSDate date] timeIntervalSince1970];
	if (now - lastDownload <= 60)	return NO;
	lastDownload 		= [[NSDate date] timeIntervalSince1970];
	return YES;
}
@end


// NSArray *itemDicts = [jsonDictionary[@"items"] copy];  NSMutableArray *items = [NSMutableArray array]; [jsonDictionary removeObjectForKey:@"items"]; for (NSDictionary *itemDict in itemDicts) { [items addObject:[SIInboxModel inboxItemUsingDictionary:itemDict]];	} jsonDictionary[@"items"] = items;