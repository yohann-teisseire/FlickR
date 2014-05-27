//
//  PictureViewController.m
//  FlickR
//
//  Created by yoyo2ntp on 15/05/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "PictureViewController.h"
#import "ReaderView.h"

@interface PictureViewController () <ReaderViewDelegate>

@property (weak, nonatomic) IBOutlet ReaderView *readerView;

@property(strong,nonatomic) NSArray * pictures;

@end

@implementation PictureViewController

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
    
    flickRLocation location;
    location.latitude = 35;
    location.longitude = 135;
    self.location = location;
    
    self.pictures = [FlickRPicture picturesAroundLocation:self.location];
    
    self.readerView.delegate = self;
    [self.readerView displayPageAtIndex:0 animated:NO];
}

-(int)numberOfPages{
    return (int)self.pictures.count;
}


-(UIView *)pageAtIndex:(int)index{
    FlickRPicture * picture = self.pictures[index];
    NSData * imageData = [NSData dataWithContentsOfURL:picture.url];
    
    UIImage * image = [UIImage imageWithData:imageData];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = self.readerView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
