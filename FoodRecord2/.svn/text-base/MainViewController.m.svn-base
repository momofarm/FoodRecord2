//
//  MainViewController.m
//  FoodRecord2
//
//  Created by Tim Chen on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "showLocation.h"
#import "SpotList.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation == UIInterfaceOrientationPortrait) ||
        (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown))
    {
        return YES;
    }
    else {
        return NO;
    }

}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

- (IBAction)searchFood:(id)sender {
    SpotList *s = [[SpotList alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:s];
    
    [self presentModalViewController:nav animated:YES];
    
}

- (IBAction)recordFood:(id)sender {
    showLocation *locController = [[showLocation alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:locController];
    
    [self presentModalViewController:nav animated:YES];

    
}

- (IBAction)suggest:(id)sender {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"您好!" message:@"功能尚在規劃中, 敬請期待" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [view show];

}

@end
