//
//  main.m
//  week3-MRC
//
//  Created by WooGenius on 7/24/14.
//  Copyright (c) 2014 WooGenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuzzleGame.h"

#define PUZZLE_SIZE 3

int main(int argc, const char * argv[]) {
    PuzzleGame *puzzleGame = [[PuzzleGame alloc] initPuzzle:[NSNumber numberWithInt:PUZZLE_SIZE]];
    
    [puzzleGame printPuzzle];
    
    [puzzleGame release];
    
    return 0;
}

