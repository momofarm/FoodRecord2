//
//  ShowMap.m
//  FoodRecord
//
//  Created by Tim Chen on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShowMap.h"
#import "MyAno.h"
#import "NofifyList.h"

@implementation ShowMap
@synthesize mapVIew, centerCoordinate, ano;

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

- (void) setCenterCoordinate:(CLLocationCoordinate2D)newCenterCoordinate
{
    centerCoordinate = newCenterCoordinate;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //center map within 100 meters of desired point
    MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(centerCoordinate, 100.0, 100.0);
    
    [mapVIew setRegion:rgn animated:YES];
    
    //add pin
    ano = [[MyAno alloc] init];
    //ano.coordinate = centerCoordinate;
    
    //ano.coordinate = centerCoordinate;
    
    [ano setCoordinate:centerCoordinate];
    [mapVIew addAnnotation:ano];
    
    mapVIew.delegate = self;
    
    //backup original one
    centerCoordinateOrig.latitude = centerCoordinate.latitude;
    centerCoordinateOrig.longitude = centerCoordinate.longitude;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMapVIew:nil];
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

- (IBAction)done:(id)sender {
    
    //compare and ask user should I change it
    
    if ((centerCoordinateOrig.longitude != centerCoordinate.longitude) && 
        (centerCoordinateOrig.latitude != centerCoordinate.latitude))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更改店址" 
                                                        message:@"系統偵測到您更改了店家位址, 您確定要更改嗎?" 
                                                        delegate:self 
                                                        cancelButtonTitle:@"取消" 
                                                        otherButtonTitles:@"確定", nil];
        
        [alert show];
        
        
    }
    else 
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"Cancel Button Pressed");
            [self restore];
            break;
        case 1:
            NSLog(@"ok Pressed");
            [self save];
            [self dismissModalViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}


- (void) restore
{
    centerCoordinate.latitude = centerCoordinateOrig.latitude;
    centerCoordinate.longitude = centerCoordinateOrig.longitude;
    
    //remove annotation first 
    [mapVIew removeAnnotation:ano];
    
    ano = nil;
    //add annotation 
    MKCoordinateRegion rgn = MKCoordinateRegionMakeWithDistance(centerCoordinate, 100.0, 100.0);
    
    [mapVIew setRegion:rgn animated:YES];
    
    //add pin
    ano = [[MyAno alloc] init];
       
    [ano setCoordinate:centerCoordinate];
    [mapVIew addAnnotation:ano];

    
}

- (void) save
{
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NofifyUpdateCurrentLocation object:loc];
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        centerCoordinate = annotationView.annotation.coordinate;
        
        [ano setCoordinate:centerCoordinate];
        
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MyAno class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                       reuseIdentifier:@""];
            
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.draggable = YES;
            
       }
        else
            pinView.annotation = annotation;
        
        return pinView;
    }
    
    return nil;
}

@end
