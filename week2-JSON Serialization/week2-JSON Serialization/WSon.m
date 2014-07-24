//
//  WSon.m
//  week2-JSON Serialization
//
//  Created by WooGenius on 7/20/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "WSon.h"

// Private method
@interface WSon(Private)

- (NSDictionary*) dictionaryHandler : (NSString*) objStr;
- (NSArray*) arrayHandler : (NSString*) arrStr;
- (enum objectType) typeDistributer;
- (id) parcingByType;

@end

@implementation WSon
@synthesize scanner;

- (id) jsonParse : (NSString*)jsonStr {
    scanner = [NSScanner scannerWithString:jsonStr];
    return [self parcingByType];
}

- (NSString*) jsonStringify : (id)object {
    return @"haha";
}

@end

@implementation WSon(Private)
- (id) parcingByType {
    id result = nil;
    switch ([self typeDistributer]) {
        case JSON_STR:
            
            break;
            
        default:
            break;
    }
    
    
    return result;
}



- (enum objectType)typeDistributer {
    NSString *jsonStr = [scanner string];
    char first = [jsonStr characterAtIndex:[scanner scanLocation]];
    
    switch (first) {
        case '\"':
            return JSON_STR;
        case '[':
            return JSON_ARR;
        case '{':
            return JSON_OBJ;
        case 't':
        case 'f':
            return JSON_BOOL;
        case 'n':
            return JSON_NULL;
        default:
            return JSON_NUM;
    }
}

- (NSDictionary*) dictionaryHandler : (NSString*) objStr {
    NSDictionary *result = [NSDictionary new];
    NSScanner *scanner = [NSScanner scannerWithString:objStr];
    NSCharacterSet *colon = [NSCharacterSet characterSetWithCharactersInString:@":"];
    
    while ([scanner isAtEnd] == NO) {
//        NSString *key;
//        [scanner scanUpToCharactersFromSet:colon intoString:&key];
        [scanner setScanLocation: [scanner scanLocation]+1];
//        NSLog(@"%@", key);
    }
    
    
    
    return result;
}

- (NSArray*) arrayHandler : (NSString*) arrStr {
    
    return [NSArray new];
}

@end
