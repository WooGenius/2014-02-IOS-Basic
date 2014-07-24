//
//  main.m
//  week2-JSON Serialization
//
//  Created by WooGenius on 7/17/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSon.h"

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        NSString *simpleObjJson = @"{\"my\": \"name\", \"is\": \"woogenius\"}";
        NSString *simpleArrJson = @"[\"my\", \"name\", \"is\", \"woogenius\"]";
        NSString *objJson = @"{\"id\" : 007, \"name\" : \"james\", \"weapons\" : [\"gun\", \"pen\"]}";
        NSString *arrJson = @"[ { \"id\": \"001\", \"name\" : \"john\" }, { \"id\": \"007\", \"name\" : \"james\" } ]";
        
//        NSLog(@"JSON Serialization");
        NSLog(@"%@", simpleObjJson);
//        NSLog(@"%@", [WSon jsonParse:simpleObjJson]);
//        NSLog(@"\n");
//        NSLog(@"%@", simpleArrJson);
//        NSLog(@"%@", [WSon jsonParse:simpleArrJson]);
//        NSLog(@"\n");
//        NSLog(@"%@", objJson);
//        NSLog(@"%@", [WSon jsonParse:objJson]);
//        NSLog(@"\n");
//        NSLog(@"%@", arrJson);
//        NSLog(@"%@", [WSon jsonParse:arrJson]);
//        NSLog(@"\n");
        
        NSString *foo = @"foo";
        NSString *address = foo;
        NSLog(@"%@", address);
        
        
    }
    return 0;
}

