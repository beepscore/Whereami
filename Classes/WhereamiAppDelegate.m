//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Steve Baker on 11/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"

@implementation WhereamiAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    // Create location manager object
    locationManager = [[CLLocationManager alloc] init];
    
    // Make this instance of WhereamiAppDelegate the delegate
    // it will send its messages to our WhereamiAppDelegate
    [locationManager setDelegate:self];
    
    // We wan all results from the location manager
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    // And we want it to be as accurate as possible
    // regardless of how much time/power it takes
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // http://forums.bignerdranch.com/viewtopic.php?f=47&t=521
    // Tell our manager to start looking for its location immediately
    // [locationManager startUpdatingLocation];
    // [locationManager startUpdatingHeading];
    [mapView setShowsUserLocation:YES];
    
    [window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application 
{
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc
{
    // In the Cocoa delegate pattern, delegators (e.g. locationManager) have a reference to
    // their delegate but don't retain it.  Following retain/release conventions, the
    // delegate could be completely released and deallocated without the delegator's knowledge.
    // In that case the delegator's reference would be "stale" and bad, and something else
    // might be stored at the memory location pointed to by the delegate property.
    // If we are a delegate and are going away, set the delegator's delegate property to nil
    // so the delegator won't have a bad reference.
    // In this app it won't matter, because when WhereamiAppDelegate goes away the app is ending.
    [locationManager setDelegate:nil];
    
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark Core Location delegate methods

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
    // How many seconds ago was this new location created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    // CLLocationManagers will return the last found location of the
    // device first, you don't want that data in this case.
    // I f this location was made more than 3 minutes ago, ignore it.
    if (t < -180) {
        // This is cached data, you don't want it, keep looking
        return;
    }
    MapPoint *mp = [[MapPoint alloc]
                    initWithCoordinate:[newLocation coordinate]
                    title:[locationTitleField text]];
    [mapView addAnnotation:mp];
    [mp release];
    [self foundLocation];
}

- (void)locationManager:(CLLocationManager *)manager 
       didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"%@", newHeading);    
}


- (void)locationManager:(CLLocationManager *)manager
didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}


#pragma mark -
#pragma mark MapKitDelegate methods
- (void)mapView:(MKMapView *)aMapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    // mp can be any type of object that conforms to the MKAnnotation protocol
    id <MKAnnotation> mp = [annotationView annotation];
    // MKCoordinateRegion is a structure, it's not a class we can send a message to.
    // Call C function MKCoordinateRegionMakeWithDistance to make the region.
    // Ref Hillegass p80.
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 250, 250);
    [aMapView setRegion:region animated:YES];
}

#pragma mark -
#pragma mark text field delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
    // called when 'return' key pressed. return NO to ignore.
    [self findLocation];
    [aTextField resignFirstResponder];
    return YES;
}


- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}


- (void)foundLocation
{
    [locationTitleField setText:@""];    
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];    
    [locationManager stopUpdatingLocation];
}

@end
