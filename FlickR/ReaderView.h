//
//  ReaderView.h
//  FlickR
//
//  Created by yoyo2ntp on 15/05/2014.
//  Copyright (c) 2014 account user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReaderViewDelegate <NSObject>

-(int) numberOfPages;

-(UIView *) pageAtIndex : (int)index;

@end


@interface ReaderView : UIView

@property (weak,nonatomic) id<ReaderViewDelegate>delegate;


-(void) displayPageAtIndex:(int)index animated:(BOOL) animated;



@end
