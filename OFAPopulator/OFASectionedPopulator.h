//
//  OFASectionedPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

@import UIKit;

@interface OFASectionedPopulator : NSObject <UITableViewDataSource, UITableViewDelegate>
-(instancetype)initWithParentView:(UIView *)parentView sectionPopulators:(NSArray *)populators;
@end
