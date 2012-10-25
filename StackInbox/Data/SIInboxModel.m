//
//  SIInboxModel.m
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SIInboxModel.h"
#import "GTMNSString+HTML.h"
NSString * const SIInboxItemTypeComment = @"comment";
NSString * const SIInboxItemTypeChatMessage = @"chat_message";
NSString * const SIInboxItemTypeNewAnswer = @"new_answer";
NSString * const SIInboxItemTypeCareersMessage = @"careers_message";
NSString * const SIInboxItemTypeCareersInvites = @"careers_invitations";
NSString * const SIInboxItemTypeMetaQuestion = @"meta_question";

@implementation SIInboxModel
@synthesize title, body, creationDate, link, isUnread, siteIconLink, siteName, type, isAPIUnread;
- (NSNumber *)creationTINumber {
	return @([self.creationDate timeIntervalSince1970]);
}
- (NSURL *)siteIconURL {
	return [NSURL URLWithString:self.siteIconLink];
}
- (NSURL *)linkURL {
	return [NSURL URLWithString:self.link];
}
+(SIInboxModel *)inboxItemUsingDictionary:(NSDictionary *)dict {
	SIInboxModel *retItem = [[SIInboxModel alloc] init];
	retItem.title = dict[@"title"];
	retItem.body = [dict[@"body"] gtm_stringByUnescapingFromHTML];
	retItem.creationDate = [NSDate dateWithTimeIntervalSince1970:[dict[@"creation_date"] doubleValue]];
	retItem.link = dict[@"link"];
	retItem.isAPIUnread = [dict[@"is_unread"] boolValue];
	retItem.siteIconLink = dict[@"site"][@"icon_url"];
	retItem.siteName = dict[@"site"][@"name"];
	retItem.type = dict[@"type"];
	return retItem;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.title forKey:@"title"];
	[aCoder encodeObject:self.body forKey:@"body"];
	[aCoder encodeObject:self.creationDate forKey:@"creationDate"];
	[aCoder encodeObject:self.link forKey:@"link"];
	[aCoder encodeBool:self.isUnread forKey:@"isUnread"];
	[aCoder encodeBool:self.isAPIUnread forKey:@"isAPIUnread"];
	[aCoder encodeObject:self.siteIconLink forKey:@"siteIconLink"];
	[aCoder encodeObject:self.siteName forKey:@"siteName"];
	[aCoder encodeObject:self.type forKey:@"type"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [self init]) {
		self.title = [aDecoder decodeObjectForKey:@"title"];
		self.body = [aDecoder decodeObjectForKey:@"body"];
		self.creationDate = [aDecoder decodeObjectForKey:@"creationDate"];
		self.link = [aDecoder decodeObjectForKey:@"link"];
		self.isUnread = [aDecoder decodeBoolForKey:@"isUnread"];
		self.isAPIUnread = [aDecoder decodeBoolForKey:@"isAPIUnread"];
		self.siteIconLink = [aDecoder decodeObjectForKey:@"siteIconLink"];
		self.siteName = [aDecoder decodeObjectForKey:@"siteName"];
		self.type = [aDecoder decodeObjectForKey:@"type"];
	}
	return self;
}
- (void)setUnread {
	self.isUnread = YES;
}
- (void)setRead {
	self.isUnread = NO;
}
@end
