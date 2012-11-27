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
#import "DSURLDataSource.h"



@implementation DSURLDataSourceCell
@synthesize  textLabel, backgroundColor;
//detailTextLabel,	 timeField, , imageView;

//- (void)setBackgroundColor:(NSColor*)backgroundColor
//{
//	_backgroundColor = backgroundColor ?: _backgroundColor;
//	[self setNeedsDisplay:YES];
//}

//- (void) setImage:(NSIMG*)image
//{
//	image = image;
//	backgroundColor = [image quantize][0];
//}
//- (NSC*) backgroundColor
//{

//	return/* image ? [image quantize][0] :*/ [NSC checkerboardWithFirstColor:BLACK secondColor:WHITE squareWidth:15];
//}

- (void)prepareForReuse {
	self.imageV.image = nil;
	self.backgroundColor = nil;
	[super prepareForReuse];
}

- (void)drawRect:(NSRect)dirtyRect {

	//	if (self.backgroundColor != nil) {	[self.backgroundColor setFill];  	NSRectFill(dirtyRect);	}
	//	else {
	//		[[NSColor colorWithDeviceRed:.9 green:.9 blue:.9 alpha:1.0] setFill];
	//		NSRectFill(dirtyRect);
	//	}
	//	NSBezierPath *path = [NSBezierPath bezierPath];
	//	[path moveToPoint:NSMakePoint(0, 0)];
	//	[path lineToPoint:NSMakePoint(self.frame.size.width, 0)];
	//	[path setLineWidth:1];
	//	[[NSColor grayColor] setStroke];
	//	[path stroke];

	//	if ([self isSelected]) 				NSRectFillWithColor(dirtyRect, [RANDOMCOLOR alpha:.5]);
	//	[super drawRect:dirtyRect];

//	if([self isSelected]) {
//		[self.backgroundColor
		[RANDOMCOLOR set];
//		[textLabel setAssociatedValue:[textLabel.textColor hexString]  forKey:@"oldColor" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
//		textLabel.textColor = self.backgroundColor.contrastingForegroundColor;
//	}
//	else {
//		textLabel.textColor = [NSC colorFromHexRGB:[textLabel associatedValueForKey:@"oldColor"]];
//		[[self.backgroundColor alpha:.2] set];
//    }
    //Draw the border and background
	NSBezierPath *roundedRect = [NSBezierPath bezierPathWithRect:self.bounds];//RoundedRect:[self bounds] xRadius:6.0 yRadius:6.0];
	[roundedRect fill];
	[BLACK set];
	[[NSBezierPath bezierPathWithRect:AZRectBy(dirtyRect.size.width, 3)]fill];
//	if (_image)
//		[[_image scaledToMax:AZMinDim(self.bounds.size)] drawAtPoint:NSZeroPoint];
}

@end


@implementation DSURLTestListViewController
@synthesize listView, itemsToList;

- (id)initWithNibName:(NSS *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (!(self = [super initWithNibName:nibNameOrNil bundle:[NSBundle frameworkBundleNamed:@"AtoZStack"]])) return nil;
	return self;
}

- (void)awakeFromNib
{
	listView.pBCN 		= YES;
	listView.delegate 	= self;
    itemsToList =  LogAndReturn(   [[DSURLDataSource domains] map:^id(NSString* domain) {
	   return [NSURL URLWithString:[@"http://" stringByAppendingString:domain] ];
    }]);

	[self.listView reloadData];
//	[self.listView observeFrameChangeUsingBlock:^{
//		if (self.listView.contentView.bounds.origin.y < 10) [[NSApplication sharedApplication].dockTile setBadgeLabel:nil];
//	}];
//	[AZNOTCENTER addObserver:self selector:@selector(boundsDidChange:) name:NSViewBoundsDidChangeNotification object:nil];
}

//- (void)boundsDidChange:(NSNotification *)note { }


- (NSUI)numberOfRowsInListView:(PXListView *)aListView
{
	return itemsToList.count;
}

- (PXListViewCell *)listView:(PXListView *)aListView cellForRow:(NSUI)row
{
	DSURLDataSourceCell *cell = (DSURLDataSourceCell *)[aListView dequeueCellWithReusableIdentifier:@"CellID"] ?:
					    [DSURLDataSourceCell cellLoadedFromNibNamed:@"DSURLCellNib" reusableIdentifier:@"CellID"];

    NSURL *url = itemsToList[row];// normal:row];
	cell.textLabel.stringValue = [NSString stringWithFormat:@"%ld. %@", row + 1, [url absoluteString]];
	NSS *urrrrl = [[NSIMG monoIcons][row]saveToWeb];
	cell.imageV.URL = urrrrl;
	return cell;
}
//	if (!url) return nil;
//	AZLOG(url);
//	NSLog(@"cell: %@ for row: %ld", cell, row);
//	cell.backgroundColor = RANDOMCOLOR;
// [AZFavIconManager iconForURL:url downloadHandler:^(NSImage *icon) {
//        // This also ensures that the table view returns the cell as now it still has to be returned.
//        if (icon) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSUInteger columnIndex = [_tableView.tableColumns indexOfObject:tableColumn];
//                NSTableCellView *tableCell = [_tableView viewAtColumn:columnIndex row:row makeIfNecessary:NO];
//                cell.image = icon;
//				[listView reloadData];
//				[listView reloadRowAtIndex:row];
//	});	}	}];
//	NSS *item 		= self.itemsToList[row];
//	NSS *str 			= item.title;
//	str	 					= item.type == SIInboxItemTypeComment ? [NSString stringWithFormat:@"comment on %@", item.title] :
//	item.type == SIInboxItemTypeNewAnswer ? [NSString stringWithFormat:@"new answer on %@", item.title] : str;
//	cell.textLabel.stringValue 		 = str;
//	cell.imageView.image =  			 = item.siteIconURL;
//	cell.detailTextLabel.stringValue = [item.body stringByAppendingString:@"..."];
//	cell.timeField.stringValue		 = [NSDate highestSignificantComponentStringFromDate:item.creationDate toDate:[NSDate date]];
//	cell.backgroundColor = item.isUnread ? [NSColor colorWithDeviceRed:0.739 green:0.900 blue:0.000 alpha:1.000] : cell.backgroundColor;

- (CGFloat)listView:(PXListView *)aListView heightOfRow:(NSUI)row {
	return 65;
}

- (void)listViewSelectionDidChange:(NSNotification *)aNotification
{
//	SIInboxModel *item = [self.itemsToList objectAtIndex:(NSUI)self.listView.selectedRow];
//	NSLog(@"Clicked on model: %@", [item propertiesPlease]);
//	[[NSWorkspace sharedWorkspace] openURL:item.linkURL];
//	[item setRead];
//	[self.listView setSelectedRow:]
//	[self.listView reloadData];
//	if([[NSUserDefaults standardUserDefaults] boolForKey:@"KeepInboxWhenItemOpened"]) {
//		[NSApp activateIgnoringOtherApps:YES];
//	}

}

@end

