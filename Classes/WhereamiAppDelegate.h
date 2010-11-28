//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Steve Baker on 11/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiAppDelegate : NSObject 
<UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate, MKReverseGeocoderDelegate> 
{
    UIWindow *window;
    CLLocationManager *locationManager;
    
    // reverseGeocoder runs asyncrhounously, we need to keep a reference
    // so when it calls back with success we can release it
    MKReverseGeocoder *reverseGeocoder;
    
    IBOutlet MKMapView *mapView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)findLocation;
- (void)foundLocation;

@end