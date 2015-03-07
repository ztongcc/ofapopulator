//
//  OFAMinMaxSelectionSectionPopulator.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 07/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "OFAMinMaxSelectionSectionPopulator.h"
#import "OFADataFetcher.h"


@interface OFAMinMaxSelectionSectionPopulator ()
@property (nonatomic, assign, readonly) NSUInteger min;
@property (nonatomic, assign, readonly) NSUInteger max;
@property (nonatomic, strong) NSMutableArray *selectedObjectIndiciesQueue;
@property (nonatomic, copy) void (^ originalSelector)(id, UIView *, NSIndexPath *);

@property (nonatomic, weak) id<OFADataFetcher> dataFetcher;
@property (nonatomic, weak) UIView *parentView;

@end

@implementation OFAMinMaxSelectionSectionPopulator
-(instancetype)initWithParentView:(UIView *)parentView
                     minSelection:(NSUInteger)min
                     maxSelection:(NSUInteger)max
                      dataFetcher:(id<OFADataFetcher>)dataFetcher
                        cellClass:(Class)cellClass 
                   cellIdentifier:(NSString *(^)(id, NSIndexPath *))cellIdentifier
                 cellConfigurator:(void (^)(id, UIView *, NSIndexPath *))cellConfigurator
{
    NSAssert(max >= min, @"max must be greater tha min");
    self = [super initWithParentView:parentView
                         dataFetcher:dataFetcher
                           cellClass:cellClass
                      cellIdentifier:cellIdentifier
                    cellConfigurator:cellConfigurator];
    if (self) {
        _dataFetcher = dataFetcher;
        _parentView = parentView;
        _min = min;
        _max = max;
        _selectedObjectIndiciesQueue = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)setObjectOnCellSelected:(void (^)(id, UIView *, NSIndexPath *))objectOnCellSelected
{
    self.originalSelector = objectOnCellSelected;
    
    __weak typeof(self) weakSelf = self;
    [super setObjectOnCellSelected:^(id obj, UIView *v, NSIndexPath *ip) {
        
        typeof(weakSelf) self = weakSelf;
        if (self) {
            NSNumber *index = @(ip.row);
            if ([self.selectedObjectIndiciesQueue containsObject:index]) {
                if([self.selectedObjectIndiciesQueue count] > self.min){
                    [self.selectedObjectIndiciesQueue removeObject:index];
                    [(UITableViewCell *)v setAccessoryType:UITableViewCellAccessoryNone];
                }
            } else {
                if ([self.selectedObjectIndiciesQueue count] >= self.max) {
                    
                    NSNumber *objectToRemoveindex = [self.selectedObjectIndiciesQueue objectAtIndex:0];
                    NSIndexPath *ipViewToDeselect = [NSIndexPath indexPathForRow:[objectToRemoveindex integerValue] inSection:ip.section];
                    [[(UITableView *)self.parentView cellForRowAtIndexPath:ipViewToDeselect] setAccessoryType:UITableViewCellAccessoryNone];
                    
                    [self.selectedObjectIndiciesQueue removeObjectAtIndex:0];
                }
                [self.selectedObjectIndiciesQueue addObject:index];
                
                NSIndexPath *ipViewToSelect = [NSIndexPath indexPathForRow:[index integerValue] inSection:ip.section];
                [[(UITableView *)self.parentView cellForRowAtIndexPath:ipViewToSelect] setAccessoryType:UITableViewCellAccessoryCheckmark];

            }
            
        
            NSMutableArray *selectedObjects = [@[] mutableCopy];
            [self.selectedObjectIndiciesQueue enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
                [selectedObjects addObject:[self.dataFetcher sectionObjects][[number integerValue]] ];
            }];
            
            self.originalSelector ([selectedObjects copy], v, ip);
        }

    }];
}


@end
