//
//  OFATableViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFATableViewSectionPopulator.h"

@implementation OFATableViewSectionPopulator

-(instancetype)initWithParentView:(UITableView *)parentView
                      dataFetcher:(id<OFADataFetcher>)dataFetcher
                        cellClass:(Class)cellClass
                   cellIdentifier:(NSString* (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                 cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        _parentView = parentView;
        _dataFetcher = dataFetcher;
        _cellConfigurator = cellConfigurator;
        _cellIdentifier = cellIdentifier;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataFetcher sectionObjects] count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier([self.dataFetcher sectionObjects][indexPath.row], indexPath) forIndexPath:indexPath];
    self.cellConfigurator([self.dataFetcher sectionObjects][indexPath.row], cell, indexPath);
    return cell;
}


@end
