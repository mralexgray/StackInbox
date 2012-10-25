//
//  SIListViewCell.h
//  StackInbox
//
//  Created by Jonathan Bailey on 19/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PXListViewCell.h"
#import "EGOImageView.h"

@interface SIListViewCell : PXListViewCell

@property (unsafe_unretained) 			  IBOutlet NSTextField 	*timeField;
@property (nonatomic, strong) IBOutlet NSTextField 	*textLabel, *detailTextLabel;
@property (nonatomic, strong) IBOutlet EGOImageView *imageView;
@property (nonatomic, strong)		   NSColor	 	*backgroundColor;

@end
