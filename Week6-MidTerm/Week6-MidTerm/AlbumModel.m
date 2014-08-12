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
            
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        self.objects = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    
    return self;
}

- (void)reloadTableView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:self userInfo:@{@"result": self.objects}];
}

- (void)sortObjectsBy:(NSString *)key
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.objects = [[NSMutableArray alloc] initWithArray:[self.objects sortedArrayUsingDescriptors:sortDescriptors]];
}

- (NSMutableArray *)getAlbumObjects
{
    return self.objects;
}

- (NSInteger)getCount
{
    return self.objects.count;
}

@end
