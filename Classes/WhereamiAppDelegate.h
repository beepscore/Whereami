//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Steve Baker on 11/6/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereamiAppDelegate : NSObject 
<UIApplicationDelegate, CLLocationManagerDelegate> 
{
    UIWindow *window;
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

