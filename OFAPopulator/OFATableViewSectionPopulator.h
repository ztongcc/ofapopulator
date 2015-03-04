//
//  OFATableViewSectionPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFASectionPopulator.h"

@interface OFATableViewSectionPopulator : NSObject <OFASectionPopulator>
@property(nonatomic, weak) UITableView *parentView;

@property (nonatomic, strong) id<OFADataFetcher> dataFetcher;
@property (nonatomic, copy) NSString* (^cellIdentifier)(id obj, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^cellConfigurator)(id, UITableViewCell *, NSIndexPath *);

-(instancetype)initWithParentView:(UITableView *)parentView
                      dataFetcher:(id<OFADataFetcher>)dataFetcher
                        cellClass:(Class)cellClass
                   cellIdentifier:(NSString* (^)(id obj, NSIndexPath *indexPath))cellIdentifier
                 cellConfigurator:(void (^)(id, UITableViewCell *, NSIndexPath *))cellConfigurator;
@end
