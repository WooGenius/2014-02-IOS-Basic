//
//  main.m
//  week1-File&String
//
//  Created by WooGenius on 7/17/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>

void getAllFilesAtPath(NSString *path, NSMutableArray *fileList) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *file in files) {
        BOOL isDir = NO;
        NSString *abPath = [NSString stringWithFormat:@"%@/%@",path,file];
        [fileManager fileExistsAtPath:abPath isDirectory:(&isDir)];
        
        [fileList addObject:file];
        
        if (isDir) {
            getAllFilesAtPath(abPath, fileList);
        }
    }
    
}

BOOL isExistFileNameAtPath(NSString *fileName, NSArray *fileList) {
    for (NSString *file in fileList) {
        if ([fileName isEqualToString:file]) {
            return YES;
        }
    }
    
    return NO;
}

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        NSString *PATH = @"/Users/WooGenius/Dropbox/14년 2학기/IOS";
        NSMutableArray *fileList = [NSMutableArray new];
        
        NSLog(@"파일 리스트 출력");
        getAllFilesAtPath(PATH, fileList);
        NSLog(@"%@", fileList);
        
        NSLog(@"특정파일 찾기");
        NSLog(@"%@", isExistFileNameAtPath(@"notExist.not", fileList) ? @"YES" : @"NO"); //no
        NSLog(@"%@", isExistFileNameAtPath(@".DS_Store", fileList) ? @"YES" : @"NO"); //yes
    }
    return 0;
}

