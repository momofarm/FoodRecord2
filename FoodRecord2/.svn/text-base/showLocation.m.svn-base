//
//  showLocation.m
//  FoodRecord
//
//  Created by Tim Chen on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "showLocation.h"
#import "ShowMap.h"
#import "NofifyList.h"
#import "PhotoShootModeController.h"
#import "SaveLocs.h"
#import "AppDelegate.h"
#import "NSData+Base64.h"

@implementation showLocation
@synthesize textView;
@synthesize imgView;
@synthesize scrollview;
@synthesize mapView;
@synthesize storeNameField;
@synthesize anno;
@synthesize lat, lon;
@synthesize newLat, newLon;
@synthesize locationManager;
@synthesize shooter;
@synthesize strName;
@synthesize strText;
@synthesize img;
@synthesize bPreset;
@synthesize bDidChange;
@synthesize saveData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    bScroll = NO;
    
    bUpdate = NO;
    
    bDidChange = NO;
    
    newLat = 0.0;
    
    newLon = 0.0;
    
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    UIBarButtonItem *buttonBack = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = buttonDone;
    
    self.navigationItem.leftBarButtonItem = buttonBack;
    
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    //map view init
    //[mapView setUserTrackingMode:MKUserTrackingModeFollow];
    //from now on, we are going to use current location............
    if (bPreset) //we have some default location load from outside
    {
        anno = [[MyAno alloc] initWithLocation:CLLocationCoordinate2DMake(lat, lon)];
        
        MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lon), 100.0, 100.0);
        
        [mapView setRegion:rgn animated:YES];

        [mapView addAnnotation:anno];
        
        bUpdate = YES;
        
        textView.text = strText;
        
        storeNameField.text = strName;
        
        imgView.image = img;
        
        
    }
    else 
    {
        //get location info from GPS service
        
        if ([CLLocationManager locationServicesEnabled])
        {
            if (locationManager == nil)
            {
                locationManager = [[CLLocationManager alloc] init];
            }
            
            locationManager.delegate = self;
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            
            locationManager.distanceFilter = 500;
            
            [locationManager startUpdatingLocation];
            
        }
        else 
        {
            //we set the default location to Evil Empire Head Quater
            lat = 25.03357;
            
            lon = 121.56466;
            
            anno = [[MyAno alloc] initWithLocation:CLLocationCoordinate2DMake(lat, lon)];
            
            MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lon), 100.0, 100.0);
            
            [mapView setRegion:rgn animated:YES];
            
            [mapView addAnnotation:anno];
            
        }
        
    }
    
    UITapGestureRecognizer *recog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callMap)];
    
    [mapView addGestureRecognizer:recog];
    
    //img view init
    UITapGestureRecognizer *recog2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPicture)];
    
    [imgView addGestureRecognizer:recog2];
    
    //register notification for keyboard show/hide event
    
    
    [[NSNotificationCenter defaultCenter]   addObserver:self 
                                            selector:@selector(kbHide:) 
                                            name: UIKeyboardWillHideNotification 
                                            object:nil];

    
    [[NSNotificationCenter defaultCenter]   addObserver:self 
                                            selector:@selector(kbShow:) 
                                            name:UIKeyboardWillShowNotification 
                                            object:nil];
    
    [[NSNotificationCenter defaultCenter]   addObserver:self
                                            selector:@selector(locationChange:)
                                            name:NofifyUpdateCurrentLocation
                                            object:nil];
    
    self.storeNameField.delegate = self;
    
    self.textView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (!bUpdate)
    {
        anno = [[MyAno alloc] initWithLocation:CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)];
    
        MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude), 100.0, 100.0);
    
        [mapView setRegion:rgn animated:YES];
    
        [mapView addAnnotation:anno];
        
        lat = newLocation.coordinate.latitude;
        
        lon = newLocation.coordinate.longitude;
        
        bUpdate = YES;
        
        [locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (!anno)
    {
        lat = 25.03357;
        
        lon = 121.56466;
        
        anno = [[MyAno alloc] initWithLocation:CLLocationCoordinate2DMake(lat, lon)];
        
        MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(lat, lon), 100.0, 100.0);
        
        [mapView setRegion:rgn animated:YES];
        
        [mapView addAnnotation:anno];
        
        bUpdate = YES;
        
        [locationManager stopUpdatingLocation];
    }
    else 
    {
        [locationManager stopUpdatingLocation];
    }
    
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setStoreNameField:nil];
    [self setScrollview:nil];
    [self setTextView:nil];
    [self setImgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (void)locationChange: (NSNotification *)notify
{
    CLLocation *loc = (CLLocation *)notify.object;
    
    if (loc)
    {
        MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(loc.coordinate, 100.0, 100.0);
        
        [mapView setRegion:rgn animated:YES];

        if (anno)
        {
            //delete current annotation
            [mapView removeAnnotation:anno];
            
            anno = nil;
            
            anno = [[MyAno alloc] initWithLocation:CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude)];
            
            [mapView addAnnotation:anno];
        
            newLat = loc.coordinate.latitude;
            
            newLon = loc.coordinate.longitude;
        }
        
        
    }
    
}

- (void) callMap
{
    ShowMap *map = [[ShowMap alloc] init];
    
    [map setCenterCoordinate:mapView.centerCoordinate];
    
    [self presentViewController:map animated:YES completion:^{
        if ((map.centerCoordinate.latitude != mapView.centerCoordinate.latitude) ||  //user change the coordinate
            (map.centerCoordinate.longitude != mapView.centerCoordinate.longitude))
        {
            MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(map.centerCoordinate, 100.0, 100.0);
            
            [mapView setRegion:rgn animated:YES];
            
            
            
        }
        
    }];
    
       
}

- (void) callPicture
{
    UIActionSheet *sheet = [[UIActionSheet alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [sheet addButtonWithTitle:@"從相簿中選取"];
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [sheet addButtonWithTitle:@"直接拍照"];
    }
    
    sheet.cancelButtonIndex = [sheet addButtonWithTitle:@"取消"];
   
    sheet.delegate = self;
    
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{
    NSString *string = [actionSheet buttonTitleAtIndex:buttonIndex];
 
    if (string == @"從相簿中選取")
    {
        [self selectFromAlbum];
    }
    else if (string == @"直接拍照")
    {
        [self directShoot];
        
    }
    else {
        
    }
       
}

- (void) selectFromAlbum
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

- (void) directShoot
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
    
    [self presentModalViewController:cameraUI animated: YES];

    
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
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        
        [self dismissModalViewControllerAnimated:YES];
        
        imgView.image = img;
        
    }
    
    
}

- (IBAction)endEdit:(id)sender 
{
    
 
}

- (void)kbShow: (NSNotification *)notify
{
    NSDictionary* info = [notify userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    //CGRect aRect = self.view.frame;
    //aRect.size.height -= kbSize.height;
    
    /*
    if (!CGRectContainsPoint(aRect, textView.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, textView.frame.origin.y - kbSize.height);
        [scrollview setContentOffset:scrollPoint animated:YES];
    }*/
    
    if (bScroll)
    {
        CGPoint scrollPoint = CGPointMake(0.0, kbSize.height);
        [scrollview setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)kbHide: (NSNotification *)notify
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollview.contentInset = contentInsets;
    scrollview.scrollIndicatorInsets = contentInsets;    
}

- (void) done
{
    if (!bPreset)
    {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
        SaveLocs *loc = (SaveLocs *)[NSEntityDescription insertNewObjectForEntityForName:@"SaveLocs" inManagedObjectContext:[appDelegate managedObjectContext]];
    
        //maybe we should test if any change been made?
        loc.lat = [NSNumber numberWithDouble:lat];
    
        loc.lon = [NSNumber numberWithDouble:lon];
    
        loc.name = storeNameField.text;
    
        //pic -> base64 text
    
        NSData *dataImage = UIImagePNGRepresentation(imgView.image); 
    
        // [data base64EncodedString];
    
        NSString *base64str = [dataImage base64EncodedString];
    
        loc.picofbase64 = base64str;
    
        loc.note = textView.text;
    
        loc.date = [NSDate date];
    
        NSError *error = nil;
    
        if (![[appDelegate managedObjectContext] save:&error])
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"完成!" message:@"很抱歉, 我們遇到未知的錯誤. 將會儘快修正" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            [view show];
        
            [self dismissModalViewControllerAnimated:YES];
        
        }
        else
        {
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"完成!" message:@"程式已為您記錄您所喜愛的餐廳, 之後可以在\"查記錄\"裡面找到您之前去過的餐廳." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
            [view show];
    
            [self dismissModalViewControllerAnimated:YES];
        }
        
    }
    else 
    {
        //check if update
        BOOL bChange = NO;
        
        BOOL b = [self checkData];
        
        if (b)
        {
            bChange = YES;
        }   
        
        if (bChange)
        {
            [self saveData];
            
            UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"完成!" message:@"程式已為您更新記錄." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            [view show];
        
            [self dismissModalViewControllerAnimated:YES];
            
            //need to update database data
        }
        else 
        {
             [self dismissModalViewControllerAnimated:YES];
        }
        
    }
    
}

- (void) saveData
{
    //so far, no any global variable to check should save data or not, just trust the code
    
    bDidChange = YES;
    
    saveData.name = storeNameField.text;
    
    saveData.note = textView.text;
    
    NSData *imgData = UIImagePNGRepresentation(imgView.image);
    
    NSString *base64ImgStr = [imgData base64EncodedString];
    
    saveData.picofbase64 = base64ImgStr;
    
    saveData.lat = [NSNumber numberWithDouble:newLat];
    
    saveData.lon = [NSNumber numberWithDouble:newLon];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSError *error = nil;
    
    if (![[delegate managedObjectContext] save:&error])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"錯誤" message:@"很抱歉, 我們發現了未知的錯誤, 請通知開發者" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        [self dismissModalViewControllerAnimated:YES];
    }
    
    
}


- (BOOL) checkData
{
    BOOL bCheckChange = NO;
    
    if ((newLat != 0.0) && (newLon != 0.0))
    {
        if ((newLat != lat) || (newLon != lon))
        {
            bCheckChange = YES;
        }
    }
    
    if (textView.text != strText)
    {
        bCheckChange = YES;
    }
    
    if (storeNameField.text != strName)
    {
        bCheckChange = YES;
    }
    
    if (img != imgView.image)
    {
        bCheckChange = YES;
    }
    
    
    return bCheckChange;
}

- (void) back
{
 
    [self dismissModalViewControllerAnimated:YES];
    
}

- (UIImage *)getCurrentLocShot
{
  
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [storeNameField resignFirstResponder];
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    bScroll = YES;
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        bScroll = NO;
        
        return NO;
    }
    
    return YES;
}

@end
