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

@property (strong) NSS    *title, 			*body, 		*link, 		*siteIconLink,    *siteName;
@property (strong) NSDate *creationDate;
@property (assign) BOOL    isAPIUnread,      isUnread;
@property (strong) SIInboxItemType type;

- (NSNumber*) creationTINumber;
- (NSURL*)	  siteIconURL;
- (NSURL*)	  linkURL;
- (void)	  setUnread;
- (void)	  setRead;
+ (SIInboxModel*) inboxItemUsingDictionary: (NSD*)dict;
@end
