//
//  OFASectionedPopulator.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

@import UIKit;

@interface OFATableViewPopulator : NSObject <UITableViewDelegate, UITableViewDataSource>
@end



@interface OFAViewPopulator : NSProxy <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
- (instancetype)initWithSectionPopulators:(NSArray *)populators;
- (instancetype)initWithSectionPopulators:(NSArray *)populators populatorClass:(Class)cls;

@property (nonatomic, copy) void (^didScroll)(UIScrollView *scrollView);
@end
