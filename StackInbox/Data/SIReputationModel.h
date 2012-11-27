//
//  SIInboxModel.h
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSS * const SIReputationItemTypeAskerAcceptsAnswer;
extern NSS * const SIReputationItemTypeAskerUnAcceptsAnswer;
extern NSS * const SIReputationItemTypeAnswerAccepted;
extern NSS * const SIReputationItemTypeAnswerUnAccepted;
extern NSS * const SIReputationItemTypeVoterDownvotes;
extern NSS * const SIReputationItemTypeVoterUnDownvotes;
extern NSS * const SIReputationItemTypePostDownvoted;
extern NSS * const SIReputationItemTypePostUnDownvoted;
extern NSS * const SIReputationItemTypePostUpvoted;
extern NSS * const SIReputationItemTypePostUnUpvoted;
extern NSS * const SIReputationItemTypeSuggestedEditApprovalRecieved;
extern NSS * const SIReputationItemTypePostFlaggedAsSpam;
extern NSS * const SIReputationItemTypePostFlaggedAsOffensive;
extern NSS * const SIReputationItemTypeBountyGiven;
extern NSS * const SIReputationItemTypeBountyEarned;
extern NSS * const SIReputationItemTypeBountyCancelled;
extern NSS * const SIReputationItemTypePostDeleted;
extern NSS * const SIReputationItemTypePostUnDeleted;
extern NSS * const SIReputationItemTypeAssociationBonus;
extern NSS * const SIReputationItemTypeArbitraryChange;
extern NSS * const SIReputationItemTypeVoteFradReversal;
extern NSS * const SIReputationItemTypePostMigrated;
extern NSS * const SIReputationItemTypeUserDeleted;

//extern NSS * const SIInboxItemTypeChatMessage;
//extern NSS * const SIInboxItemTypeNewAnswer;
//extern NSS * const SIInboxItemTypeCareersMessage;
//extern NSS * const SIInboxItemTypeCareersInvites;
//extern NSS * const SIInboxItemTypeMetaQuestion;

typedef NSString* SIReputationItemType;

@interface SIReputationModel : NSObject <NSCoding>

@property (strong) NSS    *title, 			//*body, 		*link, 		*siteIconLink,    *siteName;
@property (strong) NSDate *creationDate;
@property (assign) NSInteger reputationChange
//@property (assign) BOOL    isAPIUnread,      isUnread;
@property (strong) SIReputationItemType type;

- (NSNumber*) creationTINumber;
- (NSURL*)	  siteIconURL;
- (NSURL*)	  linkURL;
- (void)	  setUnread;
- (void)	  setRead;
+ (SIInboxModel*) inboxItemUsingDictionary: (NSD*)dict;
@end
