//
//  ExampleDataFetcher.m
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "ExampleDataFetcher.h"


@interface ExampleDataFetcher ()
@property (nonatomic, copy) void(^success)(void);
@end


@implementation ExampleDataFetcher

@synthesize sectionObjects = _sectionObjects;

-(void)fetchedData:(id)obj onDataFetcher:(id<OFADataFetcher>)dataFetcher
{
    self.sectionObjects = obj;
    self.success();
}


-(void)fetchingDataFaildWithError:(NSError *)error onDataFetcher:(id<OFADataFetcher>)dataFetcher
{

}

-(void)fetchSuccess:(void (^)(void))success
{
    self.success = success;
    
    NSMutableArray *results = [@[@1, @1] mutableCopy];
    for (NSUInteger i = 0; i< 20; ++i){
        NSNumber *nMinus1 = results[[results count] - 2];
        NSNumber *nMinus0 = results[[results count] - 1];
        [results addObject:@([nMinus1 integerValue] + [nMinus0 integerValue])];
    }
    [self fetchedData:[results copy]
        onDataFetcher:self];
}

@end
