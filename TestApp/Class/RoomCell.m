//
//  RoomCell.m
//  TestApp
//
//  Created by WebInfoways on 03/03/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "RoomCell.h"

@implementation RoomCell

@synthesize txtName,btnAge;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
	[self.txtName release];
    [self.btnAge release];
    
    [super dealloc];
}

@end
