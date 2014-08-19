//
//  PhotoViewController.m
//  Week6-MidTerm
//
//  Created by WooGenius on 8/12/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = nil;
    

    NSLog(@"%@", self.detailObject);
    
    self.titleLabel.text = [self.detailObject valueForKey:@"title"];
    self.dateLabel.text = [self.detailObject valueForKey:@"date"];
    
    UIImage *img = [UIImage imageNamed:[self.detailObject valueForKey:@"image"]];
    
    if (!img) {
        NSString *urlString = [self.detailObject valueForKey:@"image"];
        NSURL *url = [NSURL URLWithString:urlString];
        
        filePath = [cachesPath stringByAppendingPathComponent: [url pathComponents][2] ];

        img = [UIImage imageWithContentsOfFile:filePath];
    }
    
    [self.photoView setImage:img];
}

@end
