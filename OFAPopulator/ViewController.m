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
#import "OFASectionedPopulator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) OFASectionedPopulator *populator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[UITableViewCell class]
                                                                              cellIdentifier:^NSString* (id obj, NSIndexPath *indexPath){ return @"Section1"; }
                                                                            cellConfigurator:^(id obj, UIView *view, NSIndexPath *indexPath)
    {
        UITableViewCell *cell = (UITableViewCell *)view;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
    }];
    
    OFASectionPopulator *section2Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                                 dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                                   cellClass:[UITableViewCell class]
                                                                              cellIdentifier:^NSString* (id obj, NSIndexPath *indexPath){ return @"Section2"; }
                                                                            cellConfigurator:^(NSNumber *obj, UIView *view, NSIndexPath *indexPath)
    {
        UITableViewCell *cell = (UITableViewCell *)view;
        cell.textLabel.text = [NSString stringWithFormat:@"%@", @([obj doubleValue] * [obj doubleValue])];
    }];

    
    self.populator = [[OFASectionedPopulator alloc] initWithParentView:self.tableView
                                                     sectionPopulators:@[section1Populator, section2Populator]];

}



@end
