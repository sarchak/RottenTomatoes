//
//  CollectionViewController.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"


@interface CollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *dvdsCollectionView;
@property (strong, nonatomic) UIView *errorView;
@property (nonatomic,strong) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DVDs";
    

    self.dvdsCollectionView.delegate = self;
    self.dvdsCollectionView.dataSource = self;
    [self.dvdsCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"DVDCell"];
    [self fetchData];
    
}

- (void) fetchData {
    /* Fetch the data from the rotten tomatoes endpoint */
    NSURL *URL = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json?apikey=5u7cjrjepng6pmz2328rtft8"];
    
    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
    
    
    // Configure Request Operation
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        [self.errorView removeFromSuperview];
        NSDictionary *data = responseObject;
        self.movies = data[@"movies"];
        [self.dvdsCollectionView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.dvdsCollectionView reloadData];
        [self.refreshControl endRefreshing];
        self.errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        self.errorView.backgroundColor = [UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:1.0];
        UILabel *errorMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        
        errorMsg.text = @"Network error. Please try later!";
        errorMsg.textAlignment = NSTextAlignmentCenter;
        [self.errorView addSubview:errorMsg];
        [self.view addSubview:self.errorView];
        
        
    }];
    [requestOperation start];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [self.dvdsCollectionView dequeueReusableCellWithReuseIdentifier: @"DVDCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.movieTitle.text = movie[@"title"];
    cell.timeLabel.text = [NSString stringWithFormat:@"Runtime : %@min",  movie[@"runtime"]];
    cell.ratingsLabel.text = movie[@"mpaa_rating"];
    NSString *imageUrl = [movie valueForKeyPath:@"posters.thumbnail"];
    NSString *highRes = [imageUrl stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    [cell.posterImageView setImageWithURL:[NSURL URLWithString: imageUrl]];
//    [cell.posterImageView setImageWithURL:[NSURL URLWithString: highRes]];
//    cell.movieTitle.numberOfLines = 0;
//    cell.ratingsLabel.numberOfLines = 0;
//    cell.timeLabel.numberOfLines = 0;
    
//    [cell.movieTitle sizeToFit];
//    [cell.timeLabel sizeToFit];
//    [cell.ratingsLabel sizeToFit];
    cell.layer.borderWidth = 1.0;
    cell.layer.borderColor = [[UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:0.5] CGColor];
    return cell;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(160, 225);
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 20, 10, 20);

}


@end
