//
//  WSon.h
//  week2-JSON Serialization
//
//  Created by WooGenius on 7/20/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>

enum objectType {
    JSON_STR,
    JSON_NUM,
    JSON_OBJ,
    JSON_ARR,
    JSON_BOOL,
    JSON_NULL
};

@interface WSon : NSObject

@property(retain) NSScanner *scanner;

- (id) jsonParse : (NSString*)jsonStr;

- (NSString*) jsonStringify : (id)object;

@end // WSon
