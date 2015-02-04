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

@interface MoviesListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *movies;
@end

@implementation MoviesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib: [UINib nibWithNibName:@"MovieTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier: @"MovieCell"];
    self.tableView.rowHeight = 130;
    self.title = @"Movies";
    
    /* Customize the appearance*/

    /* Fetch the data from the rotten tomatoes endpoint */
    NSURL *URL = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=5u7cjrjepng6pmz2328rtft8"];
    
    // Initialize Request Operation
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:URL]];
    
    // Configure Request Operation
    [requestOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = responseObject;
        self.movies = data[@"movies"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Something failed");
    }];
    
    // Start Request Operation
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
    return [self.movies count];
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *imageUrl = [movie valueForKeyPath:@"posters.original"];

    NSString *highRes = [imageUrl stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
    [cell.posterImageView setImageWithURL:[NSURL URLWithString: highRes]];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"DeSElected");
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"SElected");
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here, for example:
    // Create the next view controller.
/*     *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil]; */
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
    
    MovieDetailViewController *mdvc = [[MovieDetailViewController alloc] init];
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
