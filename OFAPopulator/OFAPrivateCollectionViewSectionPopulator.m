//
//  OFACollectionViewSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 05/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAPrivateCollectionViewSectionPopulator.h"

@implementation OFAPrivateCollectionViewSectionPopulator
@synthesize objectOnCellSelected = _objectOnCellSelected;

- (instancetype)initWithParentView:(UICollectionView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                         cellClass:(Class)cellClass
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, UICollectionViewCell *, NSIndexPath *))cellConfigurator
{
    if (self = [super init]) {
        _parentView         = parentView;
        self.dataFetcher    = dataFetcher;
        _cellConfigurator   = cellConfigurator;
        self.cellIdentifier = cellIdentifier;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataFetcher sectionObjects] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier([self.dataFetcher sectionObjects][indexPath.row], indexPath)  forIndexPath:indexPath];

    self.cellConfigurator([self.dataFetcher sectionObjects][indexPath.row], cell, indexPath);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected([self.dataFetcher sectionObjects][indexPath.row], [collectionView cellForItemAtIndexPath:indexPath], indexPath);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.objectOnCellSelected) {
        self.objectOnCellSelected([self.dataFetcher sectionObjects][indexPath.row], [collectionView cellForItemAtIndexPath:indexPath], indexPath);
    }
}

@end
