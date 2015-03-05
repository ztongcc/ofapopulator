//
//  OFASectionedPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionedPopulator.h"
#import "OFASectionPopulator.h"

@interface OFASectionedPopulator ()
@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) NSArray *populators;
@end


@implementation OFASectionedPopulator
-(instancetype)initWithParentView:(UIView *)parentView sectionPopulators:(NSArray *)populators
{
    self = [super init];
    if (self) {
        _parentView = parentView;
        _populators = populators;
        
        if ([_parentView isKindOfClass:[UITableView class]]) {
            UITableView *tv = (UITableView *)_parentView;
            tv.dataSource = self;
        } else if ([_parentView isKindOfClass:[UICollectionView class]]){
            UICollectionView *cv = (UICollectionView *)_parentView;
            cv.dataSource = self;
        }
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.populators.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    return [pop tableView:tableView numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop tableView:tableView cellForRowAtIndexPath:indexPath];

}





-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.populators.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    return [pop collectionView:collectionView numberOfItemsInSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop collectionView:collectionView cellForItemAtIndexPath:indexPath];

}

@end
