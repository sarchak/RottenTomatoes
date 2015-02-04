//
//  MovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/3/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.movie[@"title"];
    NSString *imageUrl = [self.movie valueForKeyPath:@"posters.original"];
    [self.posterImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
     
}

-(void) viewWillAppear:(BOOL)animated {
    NSString *imageUrl = [self.movie valueForKeyPath:@"posters.original"];
    NSString *highRes = [imageUrl stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];

    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.posterImageView setImageWithURL:[NSURL URLWithString: highRes]];
    } completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
