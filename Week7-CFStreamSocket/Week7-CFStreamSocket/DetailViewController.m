//
//  DetailViewController.m
//  Week7-CFStreamSocket
//
//  Created by WooGenius on 8/21/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <NSStreamDelegate>
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [self readRequestToServer:@"127.0.0.1"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readRequestToServer:(NSString*)hostAddress {
    NSURL *website = [NSURL URLWithString:hostAddress];
    if (!website) {
        NSLog(@"%@ is not a valid URL", website);
        return;
    }
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)(hostAddress), 8000, &readStream, &writeStream);
    
    NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
    _outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [_outputStream setDelegate:self];
    
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [_outputStream open];
    
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"Detail View Server Connected");
            break;
            
        case NSStreamEventHasBytesAvailable: {
            NSLog(@"Detail View Bytes Available");
            if(!_responseData) {
                _responseData = [[NSMutableData alloc] init];
            }
            
            uint8_t buf[1024];
            NSInteger len = 0;
            NSInteger imgSize;
            NSInteger bytesread;
            len = [(NSInputStream*)stream read:buf maxLength:8];
            
            if (len) {
                buf[len] = '\0';
                imgSize = atoi((const char*)buf);
                
                while (imgSize > 0) {
                    bytesread = [(NSInputStream *)stream read:buf maxLength:1024];
                    [_responseData appendBytes:buf length:bytesread];
                    imgSize -= bytesread;
                }
                
                [_imgView setImage:[UIImage imageWithData:_responseData]];
                
                [_responseData setLength:0];
                
                uint8_t buf[4] = "ACK\0";
                [_outputStream write:buf maxLength:4];
            }

        }
            break;
            
        case NSStreamEventEndEncountered:
        {
            NSLog(@"Detail View Stream Close");
            [stream close];
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
            stream = nil;
            break;
        }
            
        default:
            break;
    }
}

@end
