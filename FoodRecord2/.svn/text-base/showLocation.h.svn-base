//
//  showLocation.h
//  FoodRecord
//
//  Created by Tim Chen on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAno.h"
#import "PhotoShootModeController.h"
#import "SaveLocs.h"

@interface showLocation : UIViewController<UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>
{
    
    BOOL bScroll; 
    BOOL bUpdate;
    BOOL bPreset;
    BOOL bDidChange;
    
    MyAno *anno;
    double lat;
    double lon;
    double newLat;
    double newLon;
    
    PhotoShootModeController *shooter;
    CLLocationManager *locationManager;

    NSString *strName;
    NSString *strText;
    UIImage *img;
    
    __weak SaveLocs *saveData;
}

- (UIImage *)getCurrentLocShot;
- (void) done;
- (void) back;
- (void) callMap;
- (void) callPicture;
- (void) selectFromAlbum;
- (void) directShoot;

- (void)kbShow: (NSNotification *)notify;
- (void)kbHide: (NSNotification *)notify;
- (void)locationChange: (NSNotification *)notify;
- (IBAction)endEdit:(id)sender;

- (BOOL) checkData;
- (void) saveData;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *storeNameField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) MyAno *anno;
@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;
@property (assign, nonatomic) double newLat;
@property (assign, nonatomic) double newLon;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) PhotoShootModeController *shooter;
@property (strong, nonatomic) NSString *strName;
@property (strong, nonatomic) NSString *strText;
@property (strong, nonatomic) UIImage *img;
@property (assign, nonatomic) BOOL bPreset; 
@property (assign, nonatomic) BOOL bDidChange;
@property (weak) SaveLocs *saveData;

@end
