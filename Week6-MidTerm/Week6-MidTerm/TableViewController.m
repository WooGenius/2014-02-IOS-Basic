//
//  TableViewController.m
//  Week6-MidTerm
//
//  Created by WooGenius on 8/12/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import "TableViewController.h"
#import "PhotoViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *jsonString = @"[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
    
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortObject:)];
    
    self.navigationItem.rightBarButtonItem = sortButton;
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    self.objects = json;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.objects[indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [self.objects[indexPath.row] objectForKey:@"date"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)sortObject:(id)sender
{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

    // We need an unsorted copy of the array for the animation
    NSArray *unsortedList = [self.objects copy];
    
    // Sort the elements and replace the array used by the data source with the sorted ones
    self.objects = [self.objects sortedArrayUsingDescriptors:sortDescriptors];
    
    // Prepare table for the animations batch
    [self.tableView beginUpdates];
    
    // Move the cells around
    NSInteger sourceRow = 0;
    for (NSString *object in unsortedList) {
        NSInteger destRow = [self.objects indexOfObject:object];
        
        if (destRow != sourceRow) {
            // Move the rows within the table view
            NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:sourceRow inSection:0];
            NSIndexPath *destIndexPath = [NSIndexPath indexPathForItem:destRow inSection:0];
            [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destIndexPath];
            
        }
        sourceRow++;
    }
    
    // Commit animations
    [self.tableView endUpdates];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowPhoto"]) {
        NSDictionary *object = nil;
        NSIndexPath *indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        object = self.objects[indexPath.row];
        
        [[segue destinationViewController] setDetailObject:object];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"image"
                                                     ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        // We need an unsorted copy of the array for the animation
        NSArray *unsortedList = [self.objects copy];
        
        // Sort the elements and replace the array used by the data source with the sorted ones
        self.objects = [self.objects sortedArrayUsingDescriptors:sortDescriptors];
        
        // Prepare table for the animations batch
        [self.tableView beginUpdates];
        
        // Move the cells around
        NSInteger sourceRow = 0;
        for (NSString *object in unsortedList) {
            NSInteger destRow = [self.objects indexOfObject:object];
            
            if (destRow != sourceRow) {
                // Move the rows within the table view
                NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForItem:sourceRow inSection:0];
                NSIndexPath *destIndexPath = [NSIndexPath indexPathForItem:destRow inSection:0];
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destIndexPath];
                
            }
            sourceRow++;
        }
        
        // Commit animations
        [self.tableView endUpdates];
    }
}

@end
