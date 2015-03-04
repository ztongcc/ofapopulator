//
//  OFASectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionPopulator.h"
#import "OFATableViewSectionPopulator.h"

@interface OFASectionPopulator ()
@property (nonatomic, strong) OFATableViewSectionPopulator *tableViewPopulator;

@end

@implementation OFASectionPopulator
- (instancetype)initWithParentView:(UIView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                          cellClass:(Class)cellClass
                     cellIdentifier:(NSString *(^)(id obj, NSIndexPath *indexPath))cellIdentifier
                   cellConfigurator:(void (^)(id, UIView *, NSIndexPath *))cellConfigurator
{
    self = [super init];
    if (self) {
        if ([parentView isKindOfClass:[UITableView class]]) {
            _tableViewPopulator = [[OFATableViewSectionPopulator alloc] initWithParentView:(UITableView *)parentView
                                                                               dataFetcher:dataFetcher
                                                                                 cellClass:cellClass
                                                                            cellIdentifier:cellIdentifier
                                                                          cellConfigurator:cellConfigurator];
        }
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewPopulator tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.tableViewPopulator tableView:tableView cellForRowAtIndexPath:indexPath];
}

@end
