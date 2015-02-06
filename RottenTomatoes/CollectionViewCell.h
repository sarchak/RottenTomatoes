//
//  CollectionViewCell.h
//  RottenTomatoes
//
//  Created by Shrikar Archak on 2/5/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;

@end
