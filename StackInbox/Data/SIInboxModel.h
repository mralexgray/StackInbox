//
//  SIInboxModel.h
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSS * const SIInboxItemTypeComment;
extern NSS * const SIInboxItemTypeChatMessage;
extern NSS * const SIInboxItemTypeNewAnswer;
extern NSS * const SIInboxItemTypeCareersMessage;
extern NSS * const SIInboxItemTypeCareersInvites;
extern NSS * const SIInboxItemTypeMetaQuestion;
typedef NSString* SIInboxItemType;

@interface SIInboxModel : NSObject <NSCoding>
@property (strong) NSS *title;
@property (strong) NSS *body;
@property (strong) NSDate *creationDate;
@property (strong) NSS *link;
@property (assign) BOOL isUnread;
@property (strong) NSS *siteIconLink;
@property (strong) NSS *siteName;
@property (strong) SIInboxItemType type;
@property (assign) BOOL isAPIUnread;

- (NSNumber*) creationTINumber;
- (NSURL*)	  siteIconURL;
- (NSURL*)	  linkURL;
- (void)	  setUnread;
- (void)	  setRead;
+ (SIInboxModel*) inboxItemUsingDictionary: (NSD*)dict;
@end
