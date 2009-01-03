//
//  CTableRow.m
//  TouchCode
//
//  Created by Jonathan Wight on 03/26/08.
//  Copyright 2008 Toxic Software. All rights reserved.
//

#import "CTableRow.h"

#import "CTableSection.h"
#import "CLabelledTextFieldCell.h"

@implementation CTableRow

@synthesize section;
@synthesize tag;
@dynamic cell;
@synthesize hidden;
@synthesize selectable;
@synthesize selectionAction;
@synthesize editable;
@synthesize editingStyle;

- (id)init
{
if ((self = [super init]) != NULL)
	{
	self.hidden = NO;
	self.selectable = YES;
	self.editable = NO;
	self.editingStyle = UITableViewCellEditingStyleNone;
	}
return(self);
}

- (id)initWithTag:(NSString *)inTag
{
if ((self = [self init]) != NULL)
	{
	self.tag = inTag;
	}
return(self);
}

- (id)initWithTag:(NSString *)inTag cell:(UITableViewCell *)inCell
{
if ((self = [self initWithTag:inTag]) != NULL)
	{
	self.cell = inCell;
	}
return(self);
}

- (void)dealloc
{
self.tag = NULL;
self.section = NULL;
self.cell = NULL;
//
[super dealloc];
}

#pragma mark -

- (UITableViewCell *)cell
{
if (cell == NULL)
	{
	UITableViewCell *theCell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
	cell = [theCell retain];
	}
return(cell); 
}

- (void)setCell:(UITableViewCell *)inCell
{
if (cell != inCell)
	{
	[cell autorelease];
	cell = [inCell retain];
    }
}

@end

#pragma mark -

@implementation CTableRow (CTableRow_ConvenienceExtensions)

- (id)initWithTag:(NSString *)inTag title:(NSString *)inTitle
{
return([self initWithTag:inTag title:inTitle value:NULL accessoryType:UITableViewCellAccessoryNone]);
}

- (id)initWithTag:(NSString *)inTag title:(NSString *)inTitle value:(NSString *)inValue
{
return([self initWithTag:inTag title:inTitle value:inValue accessoryType:UITableViewCellAccessoryNone]);
}

- (id)initWithTag:(NSString *)inTag title:(NSString *)inTitle value:(NSString *)inValue accessoryType:(UITableViewCellAccessoryType)inAccessoryType
{
UITableViewCell *theCell = NULL;
if (inValue == NULL)
	{
	const CGRect theDefaultCellBounds = { .origin = CGPointZero, .size = { .width = 300.0, .height = 44 } };
	theCell = [[[UITableViewCell alloc] initWithFrame:theDefaultCellBounds] autorelease];
	}
else
	{
	CLabelledTextFieldCell *theLabelledValueTableViewCell = [CLabelledTextFieldCell cell];
	theLabelledValueTableViewCell.valueView.text = inValue;
	theCell = theLabelledValueTableViewCell;
	}

theCell.text = inTitle;
theCell.accessoryType = inAccessoryType;

return([self initWithTag:inTag cell:theCell]);
}

- (CGRect)frameForCellContentView
{
CGRect theCellBounds = self.cell.bounds;
theCellBounds = CGRectInset(theCellBounds, 18, 6);
return(theCellBounds);
}

@end
