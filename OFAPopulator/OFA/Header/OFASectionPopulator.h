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

@property (nonatomic, strong) id<OFADataFetcher> dataFetcher;

@optional
@property (nonatomic, copy) void (^objectOnCellSelected)(id obj, UIView *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^heightForCellAtIndexPath)(id obj, NSIndexPath *indexPath);
@property (nonatomic, copy) NSString* (^sectionIndexTitle)();
@property (nonatomic, copy) NSString * (^cellIdentifier)(id obj, NSIndexPath *indexPath);


@end

@interface OFASectionPopulator : NSProxy <OFASectionPopulator>

- (instancetype)initWithParentView:(UIView *)parentView
                       dataFetcher:(id<OFADataFetcher>)dataFetcher
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id obj, id cell, NSIndexPath *indexPath))cellConfigurator;

-(NSString *)indexTitle;
@end
