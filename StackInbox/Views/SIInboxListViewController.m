//
//  SIInboxListViewController.m
//  StackInbox
//
//  Created by Jonathan Bailey on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SIViewControllers.h"
//#import "SIInboxListViewController.h"
//#import "SIListViewCell.h"
#import "SIInboxModel.h"

@implementation SIInboxListViewController
@synthesize listView, itemsToList;

- (id)initWithNibName:(NSS *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:[NSBundle frameworkBundleNamed:@"AtoZStack"]])) return nil;  //nibBundleOrNil
	return self;
}

- (void)awakeFromNib
{
	self.listView.pBCN 		= YES;
	self.listView.delegate 	= self;
	[self.listView observeFrameChangeUsingBlock:^{
		if (self.listView.contentView.bounds.origin.y < 10) [[NSApplication sharedApplication].dockTile setBadgeLabel:nil];
	}];
//	[AZNOTCENTER addObserver:self selector:@selector(boundsDidChange:) name:NSViewBoundsDidChangeNotification object:nil];
}
//- (void)boundsDidChange:(NSNotification *)note { }

- (NSUI)numberOfRowsInListView:(PXListView *)aListView {	return self.itemsToList.count; }

- (PXListViewCell *)listView:(PXListView *)aListView cellForRow:(NSUI)row
{
	SIInboxModel   *item 			 = self.itemsToList[row];
	SIListViewCell *cell 			 = (SIListViewCell*)[aListView dequeueCellWithReusableIdentifier:@"CellID"]
									?: [SIListViewCell cellLoadedFromNibNamed:@"CellNib" reusableIdentifier:@"CellID"];

	cell.textLabel.stringValue  	 = item.type == SIInboxItemTypeComment   ? $(@"comment on %@", item.title)
								     : item.type == SIInboxItemTypeNewAnswer ? $(@"new answer on %@", item.title)
								     : item.title;

	cell.imageView.imageURL 			 = item.siteIconURL;
	cell.detailTextLabel.stringValue = [item.body stringByAppendingString:@"..."];
	cell.timeField.stringValue		 = [NSDate highestSignificantComponentStringFromDate:item.creationDate toDate:[NSDate date]];

//	cell.backgroundColor = item.isUnread ? [NSColor colorWithDeviceRed:0.739 green:0.900 blue:0.000 alpha:1.000] : cell.backgroundColor;
	return cell;
}
- (CGFloat)listView:(PXListView *)aListView heightOfRow:(NSUI)row {
	return 65;
}

- (void)listViewSelectionDidChange:(NSNotification *)aNotification
{
	SIInboxModel *item = [self.itemsToList objectAtIndex:(NSUI)self.listView.selectedRow];
	NSLog(@"Clicked on model: %@", [item propertiesPlease]);
//	[[NSWorkspace sharedWorkspace] openURL:item.linkURL];
//	[item setRead];
//	[self.listView setSelectedRow:]
//	[self.listView reloadData];
//	if([[NSUserDefaults standardUserDefaults] boolForKey:@"KeepInboxWhenItemOpened"]) {
//		[NSApp activateIgnoringOtherApps:YES];
//	}

}

@end
