//
//  PhotoShootModeController.m
//  FoodRecord
//
//  Created by Tim Chen on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoShootModeController.h"

@interface PhotoShootModeController ()

@end

@implementation PhotoShootModeController
@synthesize btChooseFromAlbum;
@synthesize btDirectShoot;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIBarButtonItem *buttonBack = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = buttonBack;
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    //check camera support
    [btChooseFromAlbum setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [btDirectShoot setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    btChooseFromAlbum.enabled = NO;
    
    btDirectShoot.enabled = NO;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        btChooseFromAlbum.enabled = YES;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        btDirectShoot.enabled = YES;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBtChooseFromAlbum:nil];
    [self setBtDirectShoot:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)fromAlbum:(id)sender 
{
     UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
     cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     
     // Displays a control that allows the user to choose picture or
     // movie capture, if both are available:
     cameraUI.mediaTypes =
     [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypePhotoLibrary];
     
     // Hides the controls for moving & scaling pictures, or for
     // trimming movies. To instead show the controls, use YES.
     cameraUI.allowsEditing = NO;
     
     cameraUI.delegate = self;
     
     
    
    [self presentModalViewController: cameraUI animated: YES];
    
}

- (IBAction)directShoot:(id)sender 
{
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = self;
    
    //[self.navigationController pushViewController:cameraUI animated:YES];
    [self presentModalViewController:cameraUI animated: YES];

}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void) back
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    if (img)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    
    
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

@end
