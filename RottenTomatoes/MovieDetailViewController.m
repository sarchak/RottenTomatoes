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
@property (weak, nonatomic) IBOutlet UIScrollView *textScrollView;
@property (weak, nonatomic) IBOutlet UILabel *movieLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingsLabel;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.movie[@"title"];
    NSString *imageUrl = [self.movie valueForKeyPath:@"posters.original"];
    [self.posterImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
    self.movieLabel.text = self.movie[@"title"];
    self.movieDetailLabel.text = self.movie[@"synopsis"];

    NSString *rcString = [NSString stringWithFormat:@"%@ , ", [self.movie valueForKeyPath:@"ratings.critics_score"]];
    NSString *raString = [NSString stringWithFormat:@"%@", [self.movie valueForKeyPath:@"ratings.audience_score"]];
    NSString *criticsScore = [@"Critics Score : "  stringByAppendingString: rcString];
    NSString *audienceScore = [@"Audience Score : "  stringByAppendingString:raString];

    self.movieRatingsLabel.text = [criticsScore stringByAppendingString:audienceScore];
    [self.movieLabel sizeToFit];
    [self.movieDetailLabel sizeToFit];
    [self.movieRatingsLabel sizeToFit];

    
    /* Adding extra 50 for some gap when we scroll to the end of the screen */
    int totalHeight = self.movieLabel.frame.size.width +  self.movieDetailLabel.frame.size.width + self.movieRatingsLabel.frame.size.width;
    self.textScrollView.contentSize = CGSizeMake(self.view.frame.size.width, totalHeight);
    self.textScrollView.delegate = self;
    
    
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


#pragma mark - Scrolling
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.textScrollView setScrollsToTop:YES];
//    scrollView.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {

    
    //NSLog(@"Started scrolling");
//    NSLog(@"In scrollview %@", NSStringFromCGPoint(scrollView.contentOffset));
//    if(scrollView.contentOffset.y > 300){
//      scrollView.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height* 0.75);
//    }

}

-(void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"In scrollview %@", NSStringFromCGPoint(scrollView.contentOffset));
}

-(void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"Will begin decelerating");
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"Will end decelerating");
}
@end
