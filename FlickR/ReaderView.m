//
//  ReaderView.m
//  FlickR
//
//  Created by yoyo2ntp on 15/05/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import "ReaderView.h"

@interface ReaderView()

@property(nonatomic,assign)int index;

@end

@implementation ReaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(!self.gestureRecognizers.count){
        
        UISwipeGestureRecognizer *  nextRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(nextPage)];
        nextRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:nextRecognizer];
        
        
        UISwipeGestureRecognizer *  beforeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(beforePage)];
        beforeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:beforeRecognizer];
        
        self.userInteractionEnabled = YES;
    }
    
}

-(void)beforePage{
    [self displayPageAtIndex:self.index-1 animated:YES];
}

-(void)nextPage{
    [self displayPageAtIndex:self.index+1 animated:YES];
}


-(void)displayPageAtIndex:(int)index animated:(BOOL)animated{
    if(index >= 0 && index < [self.delegate numberOfPages]){
        UIView * view = [self.delegate pageAtIndex:index];
        [UIView transitionWithView:self
        duration:animated ? 1 : 0
        options:UIViewAnimationOptionTransitionCrossDissolve
        animations:^{
            [self.subviews.lastObject removeFromSuperview];
            [self addSubview:view];
        }
        completion:nil];
        self.index = index;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
