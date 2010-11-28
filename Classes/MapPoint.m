//
//  MapPoint.m
//  Whereami
//
//  Created by Steve Baker on 11/27/10.
//  Copyright 2010 Beepscore LLC. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint
@synthesize coordinate, title, subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
                   title:(NSString *)aTitle
                subtitle:(NSString *)aSubtitle
{
    [super init];
    if (self)
    {
        coordinate = aCoordinate;
        [self setTitle:aTitle];
        [self setSubtitle:aSubtitle];
    }
    return self;
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    [title release];
    [subtitle release];
    [super dealloc];
}


@end
