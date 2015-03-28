//
//  OFATableViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAPrivateTableViewSectionPopulator.h"

@interface OFAPrivateTableViewSectionPopulator ()
@property(nonatomic, weak) UITableView *parentTableView;
@end

@implementation OFAPrivateTableViewSectionPopulator

@synthesize  heightForCellAtIndexPath = _heightForCellAtIndexPath;

- (instancetype)initWithParentView:(UITableView *)parentView
                      dataProvider:(id<OFADataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        self.dataProvider    = dataProvider;
        self.parentTableView = parentView;
        __weak typeof(self) weakSelf = self;
        [dataProvider dataAvailable:^{
            typeof(weakSelf) self = weakSelf;
            if (self) {
                [self.parentTableView reloadData];
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
    return [[self.dataProvider sectionObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier([self.dataProvider sectionObjects][indexPath.row], indexPath) forIndexPath:indexPath];
    self.cellConfigurator([self.dataProvider sectionObjects][indexPath.row], cell, indexPath);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected(
                                    [self.dataProvider sectionObjects][indexPath.row],
                                    [tableView cellForRowAtIndexPath:indexPath],
                                    indexPath
                                  );
    };
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected(
                                  [self.dataProvider sectionObjects][indexPath.row],
                                  [tableView cellForRowAtIndexPath:indexPath],
                                  indexPath
                                  );
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightForCellAtIndexPath) {
        return self.heightForCellAtIndexPath([self.dataProvider sectionObjects][indexPath.row],indexPath);

    }
    return tableView.rowHeight;
}


-(void)setHeightForCellAtIndexPath:(CGFloat (^)(id, NSIndexPath *))heightForCellAtIndexPath
{
    _heightForCellAtIndexPath = heightForCellAtIndexPath;
}

-(UIView *)parentView
{
    return self.parentTableView;
}

@end
