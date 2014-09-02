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
@property NSInteger dstOffset;
@property BOOL isAnimating;
@property BOOL existDst;

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger dif = _dstOffset - [scrollView contentOffset].x;
    
    if (_existDst && !_isAnimating && dif > -145 && dif < 145) {
        [scrollView setContentOffset:CGPointMake((CGFloat)_dstOffset, 0) animated:YES];
//        NSLog(@"Animating");
        _isAnimating = YES;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"Begin Dragging");
    _isAnimating = NO;
    _existDst = NO;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"Will End Dragging");
    _targetOffset = targetContentOffset->x;
    _scrollVelocity = velocity.x;
    
    // Get Dst Location
    [self getDstLocation];
    
    if (_scrollVelocity == 0) {
        [scrollView setContentOffset:CGPointMake((CGFloat)_dstOffset, 0) animated:YES];
    }
}

- (void)getDstLocation {
    // 이동거리
    NSInteger dif = (NSInteger)_targetOffset - _dstOffset;
    // 나머지
    NSInteger rest = dif % 290;
    // 나머지 보정
    if (rest < 0) {
        rest = rest + 290;
    }
    
    if (rest < 145) {
        _dstOffset = (NSInteger)(_targetOffset-rest);
    } else {
        _dstOffset = (NSInteger)(_targetOffset+(290-rest));
    }
    _existDst = YES;
    
    NSLog(@"dif : %d, rest : %d, dstOffset : %d", dif, rest, _dstOffset);
}

@end