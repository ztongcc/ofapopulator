//
//  OFASectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionPopulator.h"
#import "OFATableViewSectionPopulator.h"
#import "OFACollectionViewSectionPopulator.h"

@interface OFASectionPopulator ()
@property (nonatomic, strong) OFATableViewSectionPopulator      *tableViewPopulator;
@property (nonatomic, strong) OFACollectionViewSectionPopulator *collectionViewPopulator;

@end

@implementation OFASectionPopulator

- (instancetype)initWithParentView:(UIView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                         cellClass:(Class)cellClass
                    cellIdentifier:(NSString *(^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id, id, NSIndexPath *))cellConfigurator
{
    if (self) {
        if ([parentView isKindOfClass:[UITableView class]]) {
            _tableViewPopulator = [[OFATableViewSectionPopulator alloc] initWithParentView:(UITableView *)parentView
                                                                               dataFetcher:dataFetcher
                                                                                 cellClass:cellClass
                                                                            cellIdentifier:cellIdentifier
                                                                          cellConfigurator:cellConfigurator];
        } else if ([parentView isKindOfClass:[UICollectionView class]]) {
            _collectionViewPopulator = [[OFACollectionViewSectionPopulator alloc] initWithParentView:(UICollectionView *)parentView
                                                                                         dataFetcher:dataFetcher
                                                                                           cellClass:cellClass
                                                                                      cellIdentifier:cellIdentifier
                                                                                    cellConfigurator:cellConfigurator];
        }
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [[self activeTaget] methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([[self activeTaget] respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:[self activeTaget]];
    }
}

- (OFAAbstractPrivateSectionPopulator *)activeTaget
{
    return (_tableViewPopulator) ? : _collectionViewPopulator;
}


-(void)setObjectOnCellSelected:(void (^)(id, UIView *, NSIndexPath *))objectOnCellSelected
{
    [[self activeTaget] setObjectOnCellSelected:objectOnCellSelected];
}

-(void)setHeightForCellAtIndexPath:(CGFloat (^)(id, NSIndexPath *))heightForCellAtIndexPath
{
    [[self activeTaget] setHeightForCellAtIndexPath:heightForCellAtIndexPath];
}

-(NSString *)indexTitle
{
    
    if([[self activeTaget] sectionIndexTitle])
        return [self activeTaget].sectionIndexTitle();
    return @"";
}
@end
