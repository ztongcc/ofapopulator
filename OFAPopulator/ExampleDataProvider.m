//
//  ExampleDataProvider.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ExampleDataProvider.h"


@interface ExampleDataProvider ()
@property (nonatomic, copy) void(^success)(void);
@end


@implementation ExampleDataProvider

@synthesize sectionObjects = _sectionObjects;


-(void)dataAvailable:(void (^)(void))success
{
    self.success = success;
    
    NSMutableArray *results = [@[@1, @1] mutableCopy];
    for (NSUInteger i = 0; i< 20; ++i){
        NSNumber *nMinus1 = results[[results count] - 2];
        NSNumber *nMinus0 = results[[results count] - 1];
        [results addObject:@([nMinus1 integerValue] + [nMinus0 integerValue])];
    }
    self.sectionObjects = [results copy];
    self.success();
}


-(void)dealloc
{
    ;
}

-(NSArray *)sectionObjects
{
    return _sectionObjects;
}
@end
