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
    
    /*flickRLocation location;
    location.latitude = 35;
    location.longitude = 135;
    self.location = location;*/
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.pictures = [FlickRPicture picturesAroundLocation:self.location];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.readerView.delegate = self;
            [self.readerView displayPageAtIndex:0 animated:NO];
        });
        
    });
    
}

-(int)numberOfPages{
    return (int)self.pictures.count;
}


-(UIView *)pageAtIndex:(int)index{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.frame = self.readerView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        FlickRPicture * picture = self.pictures[index];
        NSData * imageData = [NSData dataWithContentsOfURL:picture.url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           UIImage * image = [UIImage imageWithData:imageData];
            imageView.image = image;
        });
        
    });
    
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
