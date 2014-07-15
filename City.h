//
//  City.h
//  FlickR
//
//  Created by yoyo2ntp on 19/06/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;

@end
