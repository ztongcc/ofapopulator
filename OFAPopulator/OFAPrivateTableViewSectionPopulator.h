//
//  OFATableViewSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAAbstractPrivateSectionPopulator.h"

@interface OFAPrivateTableViewSectionPopulator : OFAAbstractPrivateSectionPopulator
@property(nonatomic, weak) UITableView *parentView;
@property (nonatomic, copy) void (^cellConfigurator)(id, UITableViewCell *, NSIndexPath *);

- (instancetype)initWithParentView:(UITableView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                         cellClass:(Class)cellClass
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator;

@end
