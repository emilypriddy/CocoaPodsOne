//
//  ViewController.m
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/12/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import "ViewController.h"
#import "ModalTestViewController.h"
#import "AFPopupView.h"
#import "WEPopoverContentViewController.h"
#import "WEPopoverController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *toggleButton;
@property (nonatomic, strong) ModalTestViewController *modelTest;
@property (nonatomic, strong) AFPopupView *popup;

@end

@implementation ViewController

- (IBAction)onButtonClick:(UIButton *)button
{
    if (self.wePopoverController) {
        [self.wePopoverController dismissPopoverAnimated:YES];
        self.wePopoverController = nil;
        [button setTitle:@"Show Popover" forState:UIControlStateNormal];
    } else {
        UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        
        self.wePopoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController];
        [self.wePopoverController presentPopoverFromRect:button.frame
                                                inView:self.view
                              permittedArrowDirections:UIPopoverArrowDirectionDown
                                              animated:YES];
        [button setTitle:@"Hide Popover" forState:UIControlStateNormal];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:Nil];
    _modelTest = [storyboard instantiateViewControllerWithIdentifier:@"ModalTest"];
    
    [_toggleButton addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide) name:@"HideAFPopup" object:nil];
    
    UIBarButtonItem *popoverButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(viewPopover:)];
    self.navigationItem.rightBarButtonItem = popoverButton;
}

- (void)go
{
    _popup = [AFPopupView popupWithView:_modelTest.view];
    [_popup show];
}

- (void)hide
{
    [_popup hide];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
