//
//  SIInboxDownloader.h
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@protocol SIInboxDownloaderDelegate

- (void) finishedDownloadingJSON: (NSDictionary *)jsonObject;
- (void) updateProgressWithDecimalPercent: (float)percent;
@optional
- (void) downloadNotStarted: (NSUInteger)seconds;

@end

@interface SIInboxDownloader : NSObject  

@property (nonatomic, strong) NSString *json;
@property (nonatomic, unsafe_unretained) id <SIInboxDownloaderDelegate>delegate;
@property (assign) 			  NSTimeInterval lastDownload;

- (void) startDownloadWithAccessToken: (NSString *)accessToken;
- (BOOL) canStartDownload;

@end
