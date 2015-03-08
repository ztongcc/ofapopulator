//
//  FlickerPhotoFetcher.m
//  OFAExample
//
//  Created by Manuel Meyer on 19/01/15.
//  Copyright (c) 2015 com.vs. All rights reserved.
//

#import "FlickerPhotoFetcher.h"
#import "FlickrKit.h"

#import "flickerCredentials.h"

@interface FlickerPhotoFetcher ()
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, copy) void (^success)(void);
@end

@implementation FlickerPhotoFetcher
@synthesize sectionObjects = _sectionObjects;
+(void)initialize
{
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:FLICKR_KEY
                                         sharedSecret:FLICKR_SECRET];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.photos = [@[] mutableCopy];
    }
    return self;
}

-(NSArray *)sectionObjects
{
    @synchronized(self.photos){
        return [self.photos copy];
    }
}


-(void)fetchSuccess:(void (^)(void))success
{
    self.success = success;
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    FKFlickrInterestingnessGetList *interesting = [[FKFlickrInterestingnessGetList alloc] init];
    [fk call:interesting completion:^(NSDictionary *response, NSError *error) {
        // Note this is not the main thread!
        if (response) {
            NSMutableArray *photoURLs = [NSMutableArray array];
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"]) {
                NSURL *url = [fk photoURLForSize: [[UIScreen mainScreen] scale] > 1 ? FKPhotoSizeMedium640 : FKPhotoSizeSmall320 fromPhotoDictionary:photoData];
                [photoURLs addObject:url];
            }
            [self fetchPhotos:photoURLs];
        }
    }];

}

-(void)fetchingDataFaildWithError:(NSError *)error onDataFetcher:(id<OFADataFetcher>)dataFetcher
{

}

-(void)fetchedData:(id)obj onDataFetcher:(id<OFADataFetcher>)dataFetcher
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.success();
    });
}

-(void)fetchPhotos:(NSArray *)photpURLs
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    __weak typeof(self) weakSelf = self;
    
    [[photpURLs subarrayWithRange:NSMakeRange(0, 10)] enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL *stop) {
        [queue addOperationWithBlock: ^ {
            typeof(weakSelf) strongSelf = weakSelf;
            if(strongSelf){
                NSError *error = nil;
                NSData *data = [NSData dataWithContentsOfURL:url options:0 error:&error];
                UIImage *image = nil;
                if (data){
                    image = [UIImage imageWithData:data];
                }
                if (image) {
                    @synchronized(self.photos){
                        [self.photos addObject:image];
                        [self fetchedData:self.photos onDataFetcher:self];
                    }
                }
                
            }
        }];
    }];

}

@end
