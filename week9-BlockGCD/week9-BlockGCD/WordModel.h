//
//  WordModel.h
//  week9-BlockGCD
//
//  Created by WooGenius on 9/4/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordModel : NSObject

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *objects;

- (NSMutableArray*) getObjects;

@end
