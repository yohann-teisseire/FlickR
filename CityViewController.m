//
//  CityViewController.m
//  FlickR
//
//  Created by yoyo2ntp on 19/06/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "CityViewController.h"
#import "City+CRUD.h"
#import "PictureViewController.h"
@import CoreLocation;

@interface CityViewController ()

@property(nonatomic,strong) NSArray * cities;

@end

@implementation CityViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   /* City * city = [City newCity];
    city.name = @"Kyoto";
    city.longitude = @135;
    city.latitude = @35;
    
    [[City delegate] saveContext];*/
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(localizeCities) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void)localizeCities
{
    [self.cities enumerateObjectsUsingBlock:^(City * city, NSUInteger idx, BOOL *stop) {
        CLLocation * location  = [[CLLocation alloc] initWithLatitude:city.latitude.doubleValue longitude:city.longitude.doubleValue];
        
        CLGeocoder * geocoder = [[CLGeocoder alloc]init];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if(error){
                city.name = @"Erreur de localisation";
            }else if(placemarks.count){
                CLPlacemark * placemark = placemarks.lastObject;
                if(placemark.locality.length){
                    city.name = placemark.locality;
                }else if(placemark.country.length){
                    city.name = placemark.country;
                }
                else{
                    city.name = @"tu t'es perdu ? :)";
                }
            }
            else{
                city.name = @"Zone internationnale";
            }
            [[City delegate] saveContext];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        
    }];
    [self.refreshControl endRefreshing];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.cities = [City allCities];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    
    City * city = self.cities[indexPath.row];
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"lat : %f / lon : %f", city.latitude.doubleValue,city.longitude.doubleValue];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.cities [indexPath.row] deleteCity];
        self.cities = [City allCities];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"toPictureViewController"]){
        PictureViewController * destination = segue.destinationViewController;
        City * city = self.cities[self.tableView.indexPathForSelectedRow.row];
        
        flickRLocation location;
        location.latitude = city.latitude.doubleValue;
        location.longitude = city.longitude.doubleValue;
        
        destination.location = location;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}











@end
