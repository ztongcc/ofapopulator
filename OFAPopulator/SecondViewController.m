//
//  SecondViewController.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 05/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "SecondViewController.h"
#import "OFAViewPopulator.h"
#import "OFASectionPopulator.h"

#import "ExampleDataFetcher.h"
#import "ExampleCollectionViewCell.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) OFAViewPopulator        *populator;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.collectionView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[ExampleCollectionViewCell class]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return indexPath.row % 2 ? @"cell" : @"cell2"; }
                                                                            cellConfigurator:^(id obj, ExampleCollectionViewCell *cell, NSIndexPath *indexPath)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
    }];

    section1Populator.objectOnCellSelected = ^(id obj, UIView *cell, NSIndexPath *indexPath)
    {
        ExampleCollectionViewCell *cvc = (ExampleCollectionViewCell *)cell;
        cvc.textLabel.text = [cvc.textLabel.text stringByAppendingString:@"*"];
     };
    
    OFASectionPopulator *section2Populator = [[OFASectionPopulator alloc] initWithParentView:self.collectionView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[UICollectionViewCell class]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"cell2"; }
                                                                            cellConfigurator:^(NSNumber *obj, ExampleCollectionViewCell *cell, NSIndexPath *indexPath)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
    }];
    

    self.populator = [[OFAViewPopulator alloc] initWithParentView:self.collectionView
                                                sectionPopulators:@[section1Populator, section2Populator]];
    
}

@end
