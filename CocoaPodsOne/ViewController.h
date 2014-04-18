//
//  ViewController.h
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/12/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WEPopoverController;

@interface ViewController : UIViewController {
    WEPopoverController *popoverController;
}

@property (nonatomic, retain) WEPopoverController *wePopoverController;

- (IBAction)onButtonClick:(UIButton *)button;
- (void)hide;
@end
