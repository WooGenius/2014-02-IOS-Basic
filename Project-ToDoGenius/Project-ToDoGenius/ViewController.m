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
@property CGFloat targetOffset;
@property NSInteger scrollVelocity;
@property NSInteger originOffset;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
//    UIImage *img = [UIImage imageNamed:@"hr.jpg"];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];

    [_sv setContentSize:CGSizeMake(290*30, _sv.bounds.size.height)];
//    [_sv setPagingEnabled:YES];
    [_sv setClipsToBounds:NO];
    [_sv setShowsHorizontalScrollIndicator:NO];
    [_sv setShowsVerticalScrollIndicator:NO];
    [_sv setScrollsToTop:NO];

//    [_sv addSubview:imgView];
    
    for (int i=0; i<30; i++) {
//        WGViewController *wvc = [WGViewController getWGViewControllerWithNumber:i];
//        wvc.view.frame = CGRectMake(280*i, 0, 280, 460);
//        [_sv addSubview:wvc.view];
        WGView *wv = [[[WGView alloc] init] getWGViewWithNum:i Frame:CGRectMake(290*i, 0, 280, 480)];
        
        [_sv addSubview:wv];
    }
    
    _sv.delegate = self;
    
    [_wrapper addSubview:_sv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    _targetOffset = targetContentOffset->x;
    _scrollVelocity = velocity.x;
    
    if (_scrollVelocity == 0) {
        [scrollView setContentOffset:[self getDstLocation] animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        scrollView.contentOffset = [self getDstLocation];
    } completion:^(BOOL finished){}];
}

- (CGPoint)getDstLocation {
    // 이동거리
    NSInteger dif = (NSInteger)_targetOffset - _originOffset;
    // 나머지
    NSInteger rest = dif % 290;
    // 나머지 보정
    if (rest < 0) {
        rest = rest + 290;
    }
    
    if (rest < 145) {
        _originOffset = (NSInteger)(_targetOffset-rest);
    } else {
        _originOffset = (NSInteger)(_targetOffset+(290-rest));
    }
    
    NSLog(@"dif : %d, rest : %d, offset : %d", dif, rest, _originOffset);
    return CGPointMake((CGFloat)_originOffset, 0);
}

@end