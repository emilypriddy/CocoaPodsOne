//
//  DNSExampleImageViewCell.h
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/13/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import "DNSSwipeableCell.h"

FOUNDATION_EXPORT CGFloat const kExampleCellHeight;

@interface DNSExampleImageViewCell : DNSSwipeableCell

@property (nonatomic, strong) UIImageView *exampleImageView;
@property (nonatomic, strong) UILabel *exampleLabel;
@end
