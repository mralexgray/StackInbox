//
//  SIAuthController.m
//  StackInbox
//
//  Created by Jonathan Bailey on 28/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SIAuthController.h"

@interface SIAuthController () 
@property (strong) NSWindow *window;
@property (strong) IGIsolatedCookieWebView *webView;
@end
@implementation SIAuthController
@synthesize accessToken, delegate;
@synthesize window, webView;
- (id)init {
	if (self = [super init]) {
		NSWindow *twindow = [[NSWindow alloc] init];
		[twindow setFrame:NSMakeRect(0, 0, [[[NSApp delegate] window] frame].size.width, 300) display:YES];
		self.window = twindow;
		
		IGIsolatedCookieWebView *tw = [[IGIsolatedCookieWebView alloc] initWithFrame:((NSView*)twindow.contentView).bounds];
		[tw setFrameLoadDelegate:self];
		[tw setUIDelegate:self];
		[tw setHostWindow:self.window];
		[tw setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
		self.webView = tw;
		[self.window.contentView addSubview:self.webView];
		
		[AZNOTCENTER addObserver:self selector:@selector(authProgressChanged:) name:WebViewProgressEstimateChangedNotification object:self.webView];
	}
	return self;
}

- (BOOL)hasAccessToken {
	return (self.accessToken && ![self.accessToken isEqualToString:@""]);
}

- (void)startAuth {
	NSS *scope = @"read_inbox";
	[AZNOTCENTER postNotificationName:@"SIStartAuth" object:nil];
	NSS *temp = [NSString stringWithFormat:@"https://stackexchange.com/oauth/dialog?client_id=%@&scope=%@&redirect_uri=%@", ClientID, scope, RedirectURI];
	[webView setMainFrameURL:temp];
	NSLog(@"set frame %@", temp);
}

- (void)authProgressChanged:(NSNotification *)note {
	if ([self.delegate respondsToSelector:@selector(authPercentageProgressChanged:)]) {
		WebView *webview = [note object];
		[self.delegate authPercentageProgressChanged:webview.estimatedProgress * 100];
	}
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	NSS *frameURL = [[sender mainFrameURL] copy];
	NSLog(@"lgo url %@", frameURL);
	if (![frameURL hasPrefix:RedirectURI]) { 
		[NSApp beginSheet:self.window modalForWindow:[[NSApp delegate] window] modalDelegate:nil didEndSelector:nil contextInfo:nil];
		[AZNOTCENTER postNotificationName:SIAuthWindowShown object:self];
	} else {
		[self.window orderOut:self];
		[AZNOTCENTER postNotificationName:SIAuthWindowClosed object:self];
		NSURL *url = [NSURL URLWithString:frameURL];		
		NSS *fragment = [url fragment];
		if ([fragment rangeOfString:@"error="].location != NSNotFound) {
			//failed, find why; rejected?
			if ([fragment rangeOfString:@"access_denied"].location != NSNotFound) {
				NSAlert *accessDeniedAlert = [NSAlert alertWithMessageText:@"You rejected authentication" defaultButton:@"Yes" alternateButton:@"No" otherButton:nil informativeTextWithFormat:@"To use this app you must authorize it to access your inbox, the app can only read you inbox and not modify it anyway. You can reject access at anytime in the apps tab in your user profile on any StackExchange site \n\n Do you want to retry?"];
				if ([accessDeniedAlert runModal] == NSAlertDefaultReturn) {
					[self startAuth];
				}
			}
			NSLog(@"Non access_denied error from auth dialog");
		} else if ([fragment rangeOfString:@"access_token="].location != NSNotFound) {//TODO expiry
			NSS *noID = [fragment stringByReplacingOccurrencesOfString:@"access_token=" withString:@""];
			self.accessToken = [noID substringWithRange:NSMakeRange(0, [noID rangeOfString:@"&"].location)];
			[AZNOTCENTER postNotificationName:SIAuthSuccessful object:self];
		} else {
			//unknown
			NSLog(@"Unknown response from auth dialog");
		}
	}
}

@end
