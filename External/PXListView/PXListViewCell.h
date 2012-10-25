//
//  PXListViewCell.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PXListViewDropHighlight.h"


@class PXListView;

@interface PXListViewCell : NSView
{
	NSS *_reusableIdentifier;
	
	PXListView *__unsafe_unretained _listView;
	NSUInteger _row;
	PXListViewDropHighlight	_dropHighlight;
}

@property (nonatomic, unsafe_unretained) PXListView *listView;

@property (readonly, copy) NSS *reusableIdentifier;
@property (readonly) NSUInteger row;

@property (readonly,getter=isSelected) BOOL selected;
@property (nonatomic ,assign) PXListViewDropHighlight dropHighlight;

+ (id)cellLoadedFromNibNamed: (NSS*)nibName reusableIdentifier: (NSS*)identifier;
+ (id)cellLoadedFromNibNamed: (NSS*)nibName bundle:(NSBundle*)bundle reusableIdentifier: (NSS*)identifier;

- (id)initWithReusableIdentifier: (NSS*)identifier;
- (void)prepareForReuse;

- (void)layoutSubviews;

@end
