//
//  MapPoint.h
//  Whereami
//
//  Created by Steve Baker on 11/27/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
// MapKit.h imports MKAnnotation.h, just a header file containing the protocol
#import <MapKit/MapKit.h>

@interface MapPoint : NSObject <MKAnnotation> {

}
// Center latitude and longitude of the annotion view.
// CLLocationCoordinate2D is a C structure, not instantiated as an object.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// optional methods
// Title and subtitle for use by selection UI. 
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
                   title:(NSString *)aTitle
                subtitle:(NSString *)aSubtitle;

@end
