//
//  OFADataFetcher.h
//  OFAPopulator
//
//  Created by Manuel Meyer on 02.03.15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OFADataFetcher <NSObject>
- (NSArray *)sectionObjects;
@end

