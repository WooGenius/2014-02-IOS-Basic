//
//  main.m
//  week3-MRC
//
//  Created by WooGenius on 7/24/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleGame.h"

// Set puzzle size
#define PUZZLE_SIZE 3

int main(int argc, const char * argv[]) {
    PuzzleGame *puzzleGame = [[PuzzleGame alloc] initPuzzle:[NSNumber numberWithInt:PUZZLE_SIZE]];
    
    NSLog(@"### WooGenius Puzzle Game ###");
    [puzzleGame printPuzzle];
    NSLog(@"0을 움직여서 원래의 모습으로 만드세요.");
    NSLog(@"'a':Move Left, 'd':Move Right");
    NSLog(@"'w':Move Up, 's':Move Down");
    NSLog(@"'u':Undo, 'r':Redo");
    NSLog(@"'h':Shuffle, 'e':Exit");
    NSLog(@"#############################");
    
    while (true) {
        NSLog(@"Enter Key : ");
        
        char keydown[2];
        scanf("%s", keydown);
        
        fflush(stdin);
        
        if (*keydown == 'e') {
            NSLog(@"%@", @"Exit Bye");
            [puzzleGame printPuzzle];
            NSLog(@"#############################");
            break;
        }
        
        [puzzleGame distributeEvent: *keydown];
        [puzzleGame printPuzzle];
        
        NSLog(@"#############################");
    }
    
    [puzzleGame release];
    
    return 0;
}

