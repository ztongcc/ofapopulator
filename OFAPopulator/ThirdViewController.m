//
//  ThirdViewController.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 08/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ThirdViewController.h"
#import "OFAViewPopulator.h"
#import "FlickerPhotoFetcher.h"
#import "OFASectionPopulator.h"
#import "ExampleImageCollectionViewCell.h"



@interface ThirdViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) OFAViewPopulator        *populator;

@end


@implementation ThirdViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    OFASectionPopulator *imagesPopulator = [[OFASectionPopulator alloc] initWithParentView:self.collectionView
                                                                                 dataFetcher:[[FlickerPhotoFetcher alloc] init]
                                                                                   cellClass:[ExampleImageCollectionViewCell class]
                                                                              cellIdentifier:^NSString * (id obj, NSIndexPath *indexPath){ return @"photocell"; }
                                                                            cellConfigurator:^(UIImage *image, ExampleImageCollectionViewCell *cell, NSIndexPath *indexPath)
                                              {
                                                  cell.image = image;
                                              }];
    
    
    self.populator = [[OFAViewPopulator alloc] initWithParentView:self.collectionView
                                                sectionPopulators:@[imagesPopulator]];
    
}
@end
