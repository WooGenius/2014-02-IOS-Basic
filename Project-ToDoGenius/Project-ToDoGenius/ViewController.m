//
//  ViewController.m
//  Project-ToDoGenius
//
//  Created by WooGenius on 9/1/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"
#import "WGViewController.h"
#import "WGView.h"

@implementation TouchView

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if ([self pointInside:point withEvent:event]) {
		if ([self.subviews count] == 0) return nil;
        else return [self.subviews lastObject];
	}
	return nil;
}

@end


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *sv;
@property (weak, nonatomic) IBOutlet TouchView *wrapper;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
//    UIImage *img = [UIImage imageNamed:@"hr.jpg"];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];

    [_sv setContentSize:CGSizeMake(290*6, _sv.bounds.size.height)];
    [_sv setPagingEnabled:YES];
    [_sv setClipsToBounds:NO];
    [_sv setShowsHorizontalScrollIndicator:NO];
    [_sv setShowsVerticalScrollIndicator:NO];
    [_sv setScrollsToTop:NO];

//    [_sv addSubview:imgView];
    
    for (int i=0; i<6; i++) {
//        WGViewController *wvc = [WGViewController getWGViewControllerWithNumber:i];
//        wvc.view.frame = CGRectMake(280*i, 0, 280, 460);
//        [_sv addSubview:wvc.view];
        WGView *wv = [[[WGView alloc] init] getWGViewWithNum:i Frame:CGRectMake(5+290*i, 0, 280, 480)];
        
        [_sv addSubview:wv];
    }
    
    [_wrapper addSubview:_sv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
