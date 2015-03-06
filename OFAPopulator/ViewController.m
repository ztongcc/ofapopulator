//
//  ViewController.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ViewController.h"
#import "ExampleDataFetcher.h"
#import "OFASectionPopulator.h"
#import "OFAViewPopulator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) OFAViewPopulator   *populator;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[UITableViewCell class]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return indexPath.row % 2 ? @"Section1_1" : @"Section1_2"; }
                                                                            cellConfigurator:^(id obj, UIView *view, NSIndexPath *indexPath)
    {
        UITableViewCell *cell = (UITableViewCell *)view;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];

    OFASectionPopulator *section2Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[UITableViewCell class]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"Section2"; }
                                                                            cellConfigurator:^(NSNumber *obj, UIView *view, NSIndexPath *indexPath)
    {
        UITableViewCell *cell = (UITableViewCell *)view;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }];

    self.populator = [[OFAViewPopulator alloc] initWithParentView:self.tableView
                                                sectionPopulators:@[section1Populator, section2Populator]];
}

@end
