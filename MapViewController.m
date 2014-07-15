//
//  MapViewController.m
//  FlickR
//
//  Created by yoyo2ntp on 19/06/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "MapViewController.h"
#import "City+CRUD.h"
@import MapKit;

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addLocation:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        City * city = [City newCity];
        
        city.name = @"Quelque part";
        CLLocationCoordinate2D location = [self.mapView convertPoint:[sender locationInView:self.mapView] toCoordinateFromView:self.mapView]; 
        
        city.latitude = @(location.latitude);
        city.longitude = @(location.longitude);
        
        [[City delegate]saveContext];
        
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
