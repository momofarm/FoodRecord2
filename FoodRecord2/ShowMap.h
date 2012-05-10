//
//  ShowMap.h
//  FoodRecord
//
//  Created by Tim Chen on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyAno.h"
@interface ShowMap : UIViewController<MKMapViewDelegate, UIAlertViewDelegate>
{
    CLLocationCoordinate2D centerCoordinate;
    CLLocationCoordinate2D centerCoordinateOrig;
    
    MyAno *ano;
}

- (void) restore;
- (void) save;

- (IBAction)done:(id)sender;
@property (assign, nonatomic)  CLLocationCoordinate2D centerCoordinate;
@property (weak, nonatomic) IBOutlet MKMapView *mapVIew;
@property (strong, nonatomic) MyAno *ano;
@end
