//
//  FlickRPicture.h
//  FlickR
//
//  Created by yoyo2ntp on 26/05/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef struct {
    double latitude;
    double longitude;
}flickRLocation;

@interface FlickRPicture : NSObject

@property(nonatomic,strong)NSString * picture_id;
@property(nonatomic,strong)NSNumber * farm;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * server;
@property(nonatomic,strong)NSString * secret;


-(NSURL*) url;

+(NSArray*) picturesAroundLocation:(flickRLocation)location;

@end
