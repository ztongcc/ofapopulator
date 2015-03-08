//
//  ViewController.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ViewController.h"
#import "ExampleDataFetcher.h"
#import "OFAMinMaxSelectionSectionPopulator.h"
#import "OFAViewPopulator.h"

#import "ExampleTableViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) OFAViewPopulator   *populator;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    OFASectionPopulator *section1Populator = [[OFAMinMaxSelectionSectionPopulator alloc] initWithParentView:self.tableView
                                                                                               minSelection:1
                                                                                               maxSelection:4
                                                                                                dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                                  cellClass:[ExampleTableViewCell class]
                                                                                             cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){return indexPath.row % 2 ? @"Section1_1" : @"Section1_2";}
                                                                                           cellConfigurator:^(id obj, UITableViewCell *cell, NSIndexPath *indexPath)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];

    
    section1Populator.objectOnCellSelected = ^(id obj, UIView *cell, NSIndexPath *indexPath){
        NSLog(@"%@", obj);
    };
    
    
    OFASectionPopulator *section2Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[UITableViewCell class]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"Section2"; }
                                                                            cellConfigurator:^(NSNumber *obj, UITableViewCell *cell, NSIndexPath *indexPath)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];

    self.populator = [[OFAViewPopulator alloc] initWithParentView:self.tableView
                                                sectionPopulators:@[section1Populator, section2Populator]];
}

@end
