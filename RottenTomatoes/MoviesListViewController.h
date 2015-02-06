//
//  MoviesListViewController.h
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/2/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieTableViewCell.h"

@interface MoviesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate,UISearchResultsUpdating,UISearchDisplayDelegate>
-(void) fetchData;
@end
