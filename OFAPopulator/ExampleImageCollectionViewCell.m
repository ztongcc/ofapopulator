//
//  ExampleImageCollectionViewCell.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 08/03/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ExampleImageCollectionViewCell.h"

@interface ExampleImageCollectionViewCell ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ExampleImageCollectionViewCell


-(void)setImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView = imageView;
}

-(void)setImageView:(UIImageView *)imageView
{
    [_imageView removeFromSuperview];
    _imageView = imageView;
    [self addSubview:_imageView];
}
@end
