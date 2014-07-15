//
//  City+CRUD.h
//  FlickR
//
//  Created by yoyo2ntp on 19/06/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "City.h"
#import "AppDelegate.h"

@interface City (CRUD)

+ (instancetype) newCity;

-(void) deleteCity;

+ (NSArray*) allCities;

+(AppDelegate*) delegate;

+ (NSManagedObjectContext*) context;

@end
