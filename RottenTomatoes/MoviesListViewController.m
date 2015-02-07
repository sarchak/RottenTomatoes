//
//  MoviesListViewController.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/2/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "MoviesListViewController.h"
#import "MovieTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

@interface MoviesListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *customSearchBar;

@property (strong, nonatomic) UIView *errorView;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic,strong) NSArray *movies;
@property (nonatomic,strong) NSMutableArray *filteredMovies;
@property BOOL active;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation MoviesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    /* All table view delegate and datasource setup */
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib: [UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: @"MovieCell"];
    self.tableView.rowHeight = 130;
    self.title = @"Movies";
    
    /* Customize the progress bar and setup progress bar*/
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:8.0/255 green:10.0/255 blue:15.0/255 alpha:1]];
    [SVProgressHUD setForegroundColor: [UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:1.0]];
    [SVProgressHUD show];
    
    [self fetchData];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

    self.customSearchBar.placeholder = @"Search";
    self.customSearchBar.delegate = self;
    self.customSearchBar.showsCancelButton = YES;
    self.customSearchBar.tintColor = [UIColor colorWithRed:1.0 green:206.0/255 blue:112.0/255 alpha:1.0];
    
//    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Not on this iPhone", nil]];
//    self.segmentedControl.selectedSegmentIndex = 0;
//    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
//    self.segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
//    [self.view addSubview:self.segmentedControl];
}

-(void) viewWillAppear:(BOOL)animated {
    self.active = NO;
}
-(void) viewWillDisappear:(BOOL)animated {
    self.active = NO;
}

- (void)refreshTable {
    [self fetchData];
}

- (void) fetchData {
    /* Fetch the data from the rotten tomatoes endpoint */
    NSURL *URL = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=5u7cjrjepng6pmz2328rtft8"];
    
    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
    
    
    // Configure Request Operation
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        [self.errorView removeFromSuperview];
        NSDictionary *data = responseObject;
        self.movies = data[@"movies"];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(self.active) {
        return [self.filteredMovies count];
    } else {
        return [self.movies count];
    }

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    if(self.active) {
        movie = self.filteredMovies[indexPath.row];
    }
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    cell.mpaRatings.text = [NSString stringWithFormat:@" %@ ", movie[@"mpaa_rating"]];
    cell.mpaRatings.layer.borderWidth = 1.0;
    cell.mpaRatings.layer.borderColor = [[UIColor colorWithRed:170.0/255 green:170.0/255 blue:170.0/255 alpha:1] CGColor];
    cell.mpaRatings.layer.cornerRadius = 2.0;
    [cell.mpaRatings sizeToFit];
    NSString *imageUrl = [movie valueForKeyPath:@"posters.original"];

    [cell.posterImageView setImageWithURL:[NSURL URLWithString: imageUrl]];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


#pragma mark - Search Functionality

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.active = YES;
    if([searchText isEqual:@""]){
        self.active = NO;
        [self.tableView reloadData];
    }
    [self searchFunc:searchText];
    
}


- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.active = FALSE;
    self.customSearchBar.text = nil;
    self.customSearchBar.placeholder = @"Search";
    [self.customSearchBar resignFirstResponder];
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.active = false;
    self.customSearchBar.text = nil;
    [self.tableView reloadData];
}
-(void) searchFunc: (NSString*) searchText {
    self.filteredMovies = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.movies.count; i++) {

        if([self.movies[i][@"title"] containsString:searchText]) {
            [self.filteredMovies addObject:self.movies[i]];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *movie = self.movies[indexPath.row];
    if(self.active) {
        movie = self.filteredMovies[indexPath.row];
    }
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
    mdvc.movie = movie;
    [self.navigationController pushViewController:mdvc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
