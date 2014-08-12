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

-(void)sortObjectWithAnimationBy:(NSString*)key;

@end

@implementation TableViewController
@synthesize model;

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
    
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(sortObjectByDate:)];
    self.navigationItem.rightBarButtonItem = sortButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableView:)
                                                 name:@"reloadTableView"
                                               object:nil];
    
    model = [[AlbumModel alloc] init];
    [model reloadTableView];

}

- (void)reloadTableView:(NSNotification *)noti
{
    [self.tableView reloadData];
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
    return [model getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *objects = [model getAlbumObjects];
    
    cell.textLabel.text = [objects[indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [objects[indexPath.row] objectForKey:@"date"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[model getAlbumObjects] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)sortObjectByDate:(id)sender
{
    [self sortObjectWithAnimationBy:@"date"];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowPhoto"]) {
        NSDictionary *object = nil;
        NSIndexPath *indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        object = [model getAlbumObjects][indexPath.row];
        
        [[segue destinationViewController] setDetailObject:object];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventSubtypeMotionShake) {
        model = [[AlbumModel alloc] init];
        [model reloadTableView];
    }
}

-(void)sortObjectWithAnimationBy:(NSString*)key
{
    // We need an unsorted copy of the array for the animation
    NSArray *unsortedList = [[model getAlbumObjects] copy];
    
    // Sort the elements and replace the array used by the data source with the sorted ones
    [model sortObjectsBy:key];
    
    // Prepare table for the animations batch
    [self.tableView beginUpdates];
    
    // Move the cells around
    NSInteger sourceRow = 0;
    for (NSString *object in unsortedList) {
        NSInteger destRow = [[model getAlbumObjects] indexOfObject:object];
        
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

@end
