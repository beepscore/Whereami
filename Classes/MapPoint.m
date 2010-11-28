//
//  MapPoint.m
//  Whereami
//
//  Created by Steve Baker on 11/27/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint
@synthesize coordinate, title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate title:(NSString *)aTitle {
    [super init];
    if (self) {
        coordinate = aCoordinate;
        [self setTitle:aTitle];
    }
    return self;
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    [title release];
    [super dealloc];
}


@end
