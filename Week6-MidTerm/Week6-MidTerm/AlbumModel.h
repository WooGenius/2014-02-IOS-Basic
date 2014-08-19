//
//  AlbumModel.h
//  Week6-MidTerm
//
//  Created by WooGenius on 8/12/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface AlbumModel : NSObject
@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *objects;
- (NSMutableArray*)getAlbumObjects;
- (void)sortObjectsBy:(NSString*)key;
- (NSInteger)getCount;
- (void)reloadTableView;
- (void)removePhotoAtIndex:(NSInteger)index;
@end
