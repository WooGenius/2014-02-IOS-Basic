//
//  AlbumModel.m
//  Week6-MidTerm
//
//  Created by WooGenius on 8/12/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        NSString *jsonString = @"[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";

        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:@"http://125.209.194.123/json.php"]];
//        NSURLResponse *res = nil;
//        NSError *err = nil;
        NSData *data = nil;
        
        Reachability *r = [Reachability reachabilityForLocalWiFi];
        NetworkStatus netStatus = [r currentReachabilityStatus];
        
        if (netStatus==ReachableViaWiFi) {
            [[NSURLConnection alloc] initWithRequest:req delegate:self];
        } else {
            data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            self.objects = [[NSMutableArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        }
    }
    
    return self;
}

- (void)reloadTableView {
    if (self.objects) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:self userInfo:@{@"result": self.objects}];
    }
}

- (void)sortObjectsBy:(NSString *)key
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.objects = [[NSMutableArray alloc] initWithArray:[self.objects sortedArrayUsingDescriptors:sortDescriptors]];
}

- (void)removePhotoAtIndex:(NSInteger)index {
    [self.objects removeObjectAtIndex:index];
}

- (NSMutableArray *)getAlbumObjects
{
    return self.objects;
}

- (NSInteger)getCount
{
    return self.objects.count;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSURLRequest *req = nil;
    NSURL *url = [[connection currentRequest] URL];
    NSString *urlString = [url absoluteString];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = nil;
    
    if (![urlString hasSuffix:@".jpg"]) {
        self.objects = [[NSMutableArray alloc] initWithArray:[NSJSONSerialization JSONObjectWithData:_responseData options:0 error:nil]];
        
        [self reloadTableView];
        
        for (NSDictionary *obj in self.objects) {
            req = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[obj valueForKey:@"image"]]];
            [[NSURLConnection alloc] initWithRequest:req delegate:self];
        }
        
        [_responseData setLength:0];
        
    } else {
        filePath = [cachesPath stringByAppendingPathComponent: [url pathComponents][2] ];
        
        [_responseData writeToFile:filePath atomically:YES];
        
        [_responseData setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
