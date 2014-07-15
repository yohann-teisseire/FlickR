//
//  City+CRUD.m
//  FlickR
//
//  Created by yoyo2ntp on 19/06/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "City+CRUD.h"

@implementation City (CRUD)


+(instancetype)newCity // instancier classe
{
    City* city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:[self context]];
    [[self delegate] saveContext];
    return city;
}

-(void)deleteCity // supprimer ville
{
    [[City context] deleteObject:self];
    [[City delegate] saveContext];
}

+(NSArray*)allCities // list des villes sous forme de tableau
{
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:@"City"];
    return [[self context] executeFetchRequest:request error:nil];
}

+(AppDelegate*) delegate
{
    return [[UIApplication sharedApplication]delegate];
}

+(NSManagedObjectContext*) context
{
    return [[self delegate]managedObjectContext];
}





@end
