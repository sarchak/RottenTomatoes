//
//  Movies.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/3/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movies.h"
@implementation Movies
@synthesize allMovies = _allMovies;
- (NSArray*) getMovies{
    return _allMovies;
}

@end