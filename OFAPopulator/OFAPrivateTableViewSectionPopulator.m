//
//  OFATableViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAPrivateTableViewSectionPopulator.h"

@implementation OFAPrivateTableViewSectionPopulator

- (instancetype)initWithParentView:(UITableView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                         cellClass:(Class)cellClass
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        _parentView         = parentView;
        self.dataFetcher    = dataFetcher;
        
        __weak typeof(self) weakSelf = self;
        [dataFetcher fetchSuccess:^{
            typeof(weakSelf) self = weakSelf;
            if (self) {
                [self.parentView reloadData];
            }
        }];
        _cellConfigurator   = cellConfigurator;
        self.cellIdentifier = cellIdentifier;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)   tableView:(UITableView *)tableView
    numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataFetcher sectionObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier([self.dataFetcher sectionObjects][indexPath.row], indexPath) forIndexPath:indexPath];
    self.cellConfigurator([self.dataFetcher sectionObjects][indexPath.row], cell, indexPath);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected(
                                    [self.dataFetcher sectionObjects][indexPath.row],
                                    [tableView cellForRowAtIndexPath:indexPath],
                                    indexPath
                                  );
    };
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected(
                                  [self.dataFetcher sectionObjects][indexPath.row],
                                  [tableView cellForRowAtIndexPath:indexPath],
                                  indexPath
                                  );
    };
}
@end
