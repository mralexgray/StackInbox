//
//  PXListView.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "PXListViewDelegate.h"
#import "PXListViewCell.h"

#if DEBUG
#define PXLog(...)	NSLog(__VA_ARGS__)
#endif

#define XCell PXListViewCell


@interface PXListView : NSScrollView
{
	id <PXListViewDelegate> _delegate;
	
	NSMutableArray *_reusableCells, *_visibleCells;
	NSRange _currentRange, _visibleRange;
	
	NSUInteger _numberOfRows;
	NSMutableIndexSet *_selectedRows;

	CGFloat  _totalHeight;
	CGFloat *_cellYOffsets;
	CGFloat  _cellSpacing;

	BOOL _verticalMotionCanBeginDrag, _usesLiveResize, _allowsEmptySelection, _allowsMultipleSelection;
	NSInteger _lastSelectedRow;

	CGFloat _widthPriorToResize;
	
	NSUInteger _dropRow;
	PXListViewDropHighlight	_dropHighlight;
}

@property (nonatomic, assign) IBOutlet id <PXListViewDelegate> delegate;

@property (nonatomic, retain) NSIndexSet *selectedRows;
@property (nonatomic, assign) NSUI selectedRow;

@property (nonatomic, assign) BOOL allowsEmptySelection;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) BOOL verticalMotionCanBeginDrag;

@property (nonatomic, assign) CGF  cellSpacing;
@property (nonatomic, assign) BOOL usesLiveResize;

- (void) reloadData;
- (void) reloadRowAtIndex: (NSI)inIndex;

- (XCell*)dequeueCellWithReusableIdentifier: (NSS*)identifier;

- (NSA*) visibleCells;
- (XCell *)cellForRowAtIndex: (NSUI)inIndex;

- (NSRange) visibleRange;
- (NSR)  rectOfRow: (NSUI)row;

- (void) deselectRows;
- (void) selectRowIndexes: (NSIndexSet*)rows byExtendingSelection: (BOOL)doExtend;

- (void) scrollToRow: 		 (NSUI)row;
- (void) scrollRowToVisible: (NSUI)row;

@end
