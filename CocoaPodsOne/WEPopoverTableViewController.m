//
//  WEPopoverTableViewController.m
//  CocoaPodsOne
//
//  Created by Emily Priddy on 4/13/14.
//  Copyright (c) 2014 Headstorm Studios. All rights reserved.
//

#import "WEPopoverTableViewController.h"
#import "WEPopoverContentViewController.h"
#import "UIBarButtonItem+WEPopover.h"

@interface WEPopoverTableViewController ()
@property (nonatomic, retain) WEPopoverController *wePopoverController;
@end

@implementation WEPopoverTableViewController

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Try setting this to UIPopoverController to use the iPad popover. The API is exactly the same@
    popoverClass = [WEPopoverController class];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    currentPopoverCellIndex = -1;
}

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 */

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

- (WEPopoverContainerViewProperties *)improvedContainerViewProperties {
    WEPopoverContainerViewProperties *props = [[WEPopoverContainerViewProperties alloc] init];
    NSString *bgImageName = nil;
    CGFloat bgMargin = 0.0;
    CGFloat bgCapSize = 0.0;
    CGFloat contentMargin = 4.0;
    
    bgImageName = @"popoverBg.png";
    
    // These constants are determined by the popoverBg.png image file and are image dependent.
    bgMargin  = 13; // margin width of 13 pixels on all sides popoverBg.png (62px wide - 36px background) / 2 == 26 / 2 == 13
    bgCapSize = 31; // ImageSize/2 == 62 / 2 == 31px
    
    props.leftBgMargin = bgMargin;
    props.rightBgMargin = bgMargin;
    props.topBgMargin = bgMargin;
    props.bottomBgMargin = bgMargin;
    props.leftBgCapSize = bgCapSize;
    props.topBgCapSize = bgCapSize;
    props.bgImageName = bgImageName;
    props.leftContentMargin = contentMargin;
    props.rightContentMargin = contentMargin - 1; // Need to shift one pixel for border to look correct;
    props.topContentMargin = contentMargin;
    props.bottomContentMargin = contentMargin;
    
    props.arrowMargin = 4.0;
    
    props.upArrowImageName = @"popoverArrowUp.png";
    props.downArrowImageName = @"popoverArrowDown.png";
    props.leftArrowImageName = @"popoverArrowLeft.png";
    props.rightArrowImageName = @"popoverArrowRight.png";
    return props;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push to another view controller.
    BOOL shouldShowNewPopover = indexPath.row != currentPopoverCellIndex;
    
    if (self.wePopoverController) {
        [self.wePopoverController dismissPopoverAnimated:YES];
        self.wePopoverController = nil;
        currentPopoverCellIndex = -1;
    }
    
    if (shouldShowNewPopover) {
        WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        CGRect frame = [tableView cellForRowAtIndexPath:indexPath].frame;
        CGRect rect = frame;
        
        self.wePopoverController = [[popoverClass alloc] initWithContentViewController:contentViewController];
        
        if ([self.wePopoverController respondsToSelector:@selector(setContainerViewProperties:)]) {
            [self.wePopoverController setContainerViewProperties:[self improvedContainerViewProperties]];
        }
        
        self.wePopoverController.delegate = self;
        
        self.wePopoverController.passthroughViews = [NSArray arrayWithObject:self.tableView];
        
        [self.wePopoverController presentPopoverFromRect:rect
                                                inView:self.view
                              permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown|UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight)
                                              animated:YES];
        currentPopoverCellIndex = indexPath.row;
    }
}

- (IBAction)showPopover:(id)sender
{
    if (!self.wePopoverController) {
        UIViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        self.wePopoverController = [[popoverClass alloc] initWithContentViewController:contentViewController];
        self.wePopoverController.delegate = self;
        self.wePopoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
        
        [self.wePopoverController presentPopoverFromBarButtonItem:sender
                                       permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
                                                       animated:YES];
    } else {
        self.wePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.wePopoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
