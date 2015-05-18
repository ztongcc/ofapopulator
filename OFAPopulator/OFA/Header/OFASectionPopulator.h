//
//  OFASectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

@import UIKit;
#import "OFADataProvider.h"

@protocol OFASectionPopulator <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) id<OFADataProvider> dataProvider;

@optional
@property (nonatomic, copy) void (^objectOnCellSelected)(id obj, UIView *cell, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^objectOnCellDeselected)(id obj, UIView *cell, NSIndexPath *indexPath);

@property (nonatomic, copy) CGFloat (^heightForCellAtIndexPath)(id obj, NSIndexPath *indexPath);
@property (nonatomic, copy) NSString* (^sectionIndexTitle)();
@property (nonatomic, copy) NSString * (^cellIdentifier)(id obj, NSIndexPath *indexPath);
@property (nonatomic, copy) UIView* (^header)(NSUInteger section);
@property (nonatomic, copy) UIView* (^footer)(NSUInteger section);

@property (nonatomic, weak) UIView *parentView;
@end

@interface OFASectionPopulator : NSProxy <OFASectionPopulator>
@property (nonatomic, strong) id<OFADataProvider> dataProvider;

- (instancetype)initWithParentView:(UIView *)parentView
                      dataProvider:(id<OFADataProvider>)dataProvider
                    cellIdentifier:(NSString * (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                  cellConfigurator:(void (^)(id obj, id cell, NSIndexPath *indexPath))cellConfigurator;

-(NSString *)indexTitle;
@end
