//
//  ViewController.m
//  week5-Cache
//
//  Created by WooGenius on 8/7/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *anImage;

@end

@implementation ViewController
@synthesize scrollView = _scrollView, imageView = _imageView, anImage = _anImage;

-(UIImage *)anImage
{
    if(!_anImage) _anImage = [UIImage imageNamed:@"07.jpg"];
    return _anImage;
}

-(UIImageView *)imageView
{
    if(!_imageView) _imageView = [[UIImageView alloc] initWithImage:self.anImage];
    return _imageView;
}

-(UIScrollView *)scrollView
{
    NSInteger imgWidth = 320;
    NSInteger imgHeight = 240;
    
    if(!_scrollView) {
        CGRect viewFrame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        _scrollView = [[UIScrollView alloc] initWithFrame:viewFrame];
        _scrollView.minimumZoomScale = 0.1f;
        _scrollView.maximumZoomScale = 3.0f;
        
        //setup internal views
        NSInteger numberOfViews = 22;
        for (int i = 0; i < numberOfViews; i++) {
            CGFloat yOrigin = i*240;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, yOrigin, imgWidth, imgHeight)];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat: @"%02d.jpg", i+1]];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleToFill;

            [_scrollView addSubview:imageView];
        }
        
        //set the scroll view content size
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, imgHeight*numberOfViews);
    }
    return _scrollView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int startImgNumAfterScroll = _scrollView.contentOffset.y / heightPerImage + 1;
    int endImgNumAfterScroll = (_scrollView.contentOffset.y + deviceHeight) / heightPerImage + 1;
    
    //    NSLog(@"did scroll %d - %d", startImgNumAfterScroll, endImgNumAfterScroll);
    
    if (startImgNum != startImgNumAfterScroll && startImgNum > 0 && startImgNumAfterScroll > 0) {
        if (startImgNum < startImgNumAfterScroll) {
            [self dropImgWithIndex:startImgNum];
        } else {
            [self loadImgWithIndex:startImgNumAfterScroll];
        }
    }
    
    if (endImgNum != endImgNumAfterScroll && endImgNum < (numOfImg + 1) && endImgNumAfterScroll < (numOfImg + 1)) {
        if (endImgNum < endImgNumAfterScroll) {
            [self loadImgWithIndex:endImgNumAfterScroll];
        } else {
            [self dropImgWithIndex:endImgNum];
        }
    }
    
    startImgNum = imageScroll.contentOffset.y / heightPerImage + 1;
    endImgNum = (imageScroll.contentOffset.y + deviceHeight) / heightPerImage + 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
