//
//  ParentViewController.m
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/6/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import "ParentViewController.h"

@interface ParentViewController ()
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"List DVDs", @"Grid DVDs", nil]];
    [self.segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    //[self.segmentedControl sizeToFit];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segmentedControl;
    [self.segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void) segmentValueChanged:(id)sender {
    NSLog(@"Changed");
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
