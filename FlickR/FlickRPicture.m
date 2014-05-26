//
//  FlickRPicture.m
//  FlickR
//
//  Created by yoyo2ntp on 26/05/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "FlickRPicture.h"
#define kFlicKAPIKey @"fc9ce18ffa3edc273df93290ffd146ef"

@implementation FlickRPicture

-(NSURL*) url{
    NSString * urlString = [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@.jpg", self.farm.intValue,self.server,self
                            .picture_id, self.secret];
    return [NSURL URLWithString:urlString];
}

+ (NSArray*)picturesAroundLocation:(flickRLocation)location{
    NSString * urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%f&lon=%f&format=json&nojsoncallback=1", kFlicKAPIKey, location.latitude, location.longitude];
    NSURL * url = [NSURL URLWithString:urlString];
    
    
    
    NSData * data = [NSData dataWithContentsOfURL:url];
    if(!data){
        return @[];
    }else{
        NSError * error;
        NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if(error){
            NSLog(@"ERROR JSON : %@",error.localizedDescription);
            return @[];
        }else{
            NSArray * jsonPicture = jsonObject[@"photos"][@"photo"];
            NSMutableArray * pictures = [NSMutableArray arrayWithCapacity:jsonPicture.count];
            
            for (NSDictionary * currentPicture in jsonPicture) {
                FlickRPicture * picture = [[FlickRPicture alloc]init];
                picture.picture_id = currentPicture[@"id"];
                picture.server = currentPicture[@"server"];
                picture.title = currentPicture[@"title"];
                picture.farm = currentPicture[@"farm"];
                picture.secret = currentPicture[@"secret"];
                
                [pictures addObject:picture];
            }
            return [NSArray arrayWithArray:pictures];
        }
        
    }
    
}



@end
