//
//  DetailViewController.m
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/13/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import "DetailViewController.h"
#import "UIView+draggable.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *draggableViews;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailImage:(UIImage *)detailImage
{
    _detailImage = detailImage;
    // Update the view.
    [self configureView];
}

- (void)setDetailText:(NSString *)detailText
{
    _detailText = detailText;
    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailImage) {
        self.imageView.image = self.detailImage;
    }
    
    if (self.detailText) {
        self.detailDescriptionLabel.text = self.detailText;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    [self.draggableViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj enableDragging];
        [obj.layer setCornerRadius:4];
    }];
    
    [self configureView];
}

- (IBAction)actionSwitch:(UISwitch *)sender
{
    [self.draggableViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        [obj setDraggable:sender.isOn];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
