//
//  ExampleTableViewCell.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 07/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ExampleTableViewCell.h"

@interface ExampleTableViewCell ()
@property (nonatomic, getter=isSelected) BOOL selected;
@end


@implementation ExampleTableViewCell
@dynamic selected;
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark: UITableViewCellAccessoryNone;
}


@end
