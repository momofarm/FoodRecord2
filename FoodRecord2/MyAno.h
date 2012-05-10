//
//  MyAno.h
//  FoodRecord
//
//  Created by Tim Chen on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAno : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;
//- (void) setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
