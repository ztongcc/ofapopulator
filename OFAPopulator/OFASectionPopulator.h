//
//  OFASectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

@import UIKit;
#import "OFADataFetcher.h"

@protocol OFASectionPopulator <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@optional
@property (nonatomic, copy) void (^objectOnCellSelected)(id obj, UIView *cell, NSIndexPath *indexPath);

@end

@interface OFASectionPopulator : NSProxy <OFASectionPopulator>

- (instancetype)initWithParentView:(UIView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                         cellClass:(Class)cellClass
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id obj, id cell, NSIndexPath *indexPath))cellConfigurator;
@end
