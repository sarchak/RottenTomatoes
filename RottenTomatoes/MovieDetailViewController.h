//
//  MovieDetailViewController.h
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/3/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController  <UIScrollViewDelegate>
@property (nonatomic,strong) NSDictionary *movie;
@end
