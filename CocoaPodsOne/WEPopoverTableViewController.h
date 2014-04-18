//
//  WEPopoverTableViewController.h
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/13/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"

@interface WEPopoverTableViewController : UITableViewController <WEPopoverControllerDelegate, UIPopoverControllerDelegate> {
    NSInteger currentPopoverCellIndex;
    Class popoverClass;
}

- (IBAction)showPopover:(id)sender;

@end
