//
//  OFASectionedPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAViewPopulator.h"
#import "OFASectionPopulator.h"

@interface OFAViewPopulator ()
@property (nonatomic, weak) UIView    *parentView;
@property (nonatomic, strong) NSArray *populators;
@end

@implementation OFAViewPopulator
- (instancetype)initWithParentView:(UIView *)parentView sectionPopulators:(NSArray *)populators
{
    self = [super init];
    if (self) {
        _parentView = parentView;
        _populators = populators;

        if ([_parentView isKindOfClass:[UITableView class]]) {
            UITableView *tv = (UITableView *)_parentView;
            tv.dataSource = self;
            tv.delegate = self;
            tv.allowsMultipleSelection = YES;
        } else if ([_parentView isKindOfClass:[UICollectionView class]]) {
            UICollectionView *cv = (UICollectionView *)_parentView;
            cv.dataSource = self;
            cv.delegate = self;
            cv.allowsMultipleSelection = YES;
        }
    }
    return self;
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.populators.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    return [pop tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView didDeselectRowAtIndexPath:indexPath];
    
}
#pragma mark - collectionview

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.populators.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    return [pop collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
}

@end
