//
//  DNSExampleImageViewCell.m
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/13/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import "DNSExampleImageViewCell.h"

// Public constants
CGFloat const kExampleCellHeight = 100.0f;

// Private constants
static CGFloat const kExampleCellLeftMargin = 15.0f;
static CGFloat const kExampleCellRightMargin = 20.0f;
static CGFloat const kBetweenViewsMargin = 8.0f;

@implementation DNSExampleImageViewCell

- (void)commonInit
{
    [super commonInit];
    
    // Setup the pieces of this cell which will be reused
    CGFloat imageHeight = kExampleCellHeight - (kBetweenViewsMargin * 2);
    self.exampleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kExampleCellLeftMargin, kBetweenViewsMargin, imageHeight, imageHeight)];
    [self.myContentView addSubview:self.exampleImageView];
    
    CGFloat labelXOrigin = CGRectGetMaxX(self.exampleImageView.frame) + kBetweenViewsMargin;
    CGFloat labelWidth = CGRectGetWidth(self.frame) - labelXOrigin - kExampleCellRightMargin;
    self.exampleLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelXOrigin, 0, labelWidth, kExampleCellHeight)];
    self.exampleLabel.numberOfLines = 0;
    [self.myContentView addSubview:self.exampleLabel];
}

@end
