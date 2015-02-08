//
//  MovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/3/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "FXBlurView.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *textScrollView;
@property (weak, nonatomic) IBOutlet UILabel *movieLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRatingsLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

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
    int totalHeight = self.movieLabel.frame.size.height +  self.movieDetailLabel.frame.size.height + self.movieRatingsLabel.frame.size.height + 250;

//    totalHeight += self.view.frame.size.height ;

    
//    CGRect tmpFrame = self.backgroundView.frame;
//    tmpFrame.size.height =tmpFrame.size.height + totalHeight + 250;
//    self.backgroundView.frame = tmpFrame;
//    
//    [self.backgroundView sizeToFit];
//
    self.textScrollView.contentSize = CGSizeMake(self.view.frame.size.width, totalHeight + 250);
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
//    scrollView.frame = CGRectMake(0, self.view.frame.size.height - self.textScrollView.contentSize.height, self.view.frame.size.width, self.textScrollView.contentSize.height);
}

@end
