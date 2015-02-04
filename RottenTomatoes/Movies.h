//
//  Movies.h
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/3/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#ifndef RottenTomatoes_Movies_h
#define RottenTomatoes_Movies_h

#import <Foundation/Foundation.h>

@interface Movie: NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *synopsis;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSString *ratingString;
@property (nonatomic) int score;

@end

@interface Movies: NSObject
@property (nonatomic) NSMutableArray *allMovies;
    - (NSArray*) getMovies;
@end

#endif
