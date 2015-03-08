//
//  OFASectionedPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAViewPopulator.h"
#import "OFASectionPopulator.h"



#pragma mark -

@interface OFATableViewPopulator : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView    *parentView;
@property (nonatomic, strong) NSArray *populators;
@property (nonatomic, assign) NSUInteger currentSection;
@end

@implementation OFATableViewPopulator
- (instancetype)initWithParentView:(UITableView *)tv sectionPopulators:(NSArray *)populators
{
    self = [super init];
    if (self) {
        _parentView = tv;
        _populators = populators;
        
        tv.dataSource = self;
        tv.delegate = self;
        tv.allowsMultipleSelection = YES;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.populators.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.currentSection = section;

    id<OFASectionPopulator> pop = self.populators[section];
    return [pop tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    self.currentSection = indexPath.section;
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    return [pop tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentSection = indexPath.section;

    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.currentSection = indexPath.section;

    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView didDeselectRowAtIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    [pop tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    
    if ([pop respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [pop tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    id<OFASectionPopulator> pop = self.populators[section];
    
    if ([pop respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [pop tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<OFASectionPopulator> pop = self.populators[indexPath.section];
    if ([pop respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [pop tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}


@end

#pragma mark -

@interface OFACollectionViewPopulator : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView    *parentView;
@property (nonatomic, strong) NSArray *populators;
@end


@implementation OFACollectionViewPopulator

- (instancetype)initWithParentView:(UICollectionView *)tv sectionPopulators:(NSArray *)populators
{
    self = [super init];
    if (self) {
        _parentView = tv;
        _populators = populators;
        
        tv.dataSource = self;
        tv.delegate = self;
        tv.allowsMultipleSelection = YES;
    }
    return self;
}

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


#pragma mark -

@interface OFAViewPopulator ()

@property (nonatomic, strong) id privatePopulator;
@end

@implementation OFAViewPopulator
- (instancetype)initWithParentView:(UIView *)parentView sectionPopulators:(NSArray *)populators
{
    if (self) {
        if ([parentView isKindOfClass:[UITableView class]]) {
            self.privatePopulator = [[OFATableViewPopulator alloc] initWithParentView:(UITableView *)parentView
                                                                    sectionPopulators:populators];
        } else if ([parentView isKindOfClass:[UICollectionView class]]) {
            self.privatePopulator = [[OFACollectionViewPopulator alloc] initWithParentView:(UICollectionView *)parentView
                                                                         sectionPopulators:populators];
        }
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [[self privatePopulator] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([[self privatePopulator] respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:[self privatePopulator]];
    }
}



@end
