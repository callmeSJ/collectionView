//
//  collectionCell.m
//  collectionView
//
//  Created by SJ on 16/6/9.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "collectionCell.h"

@interface collectionCell()

@property(nonatomic,strong)UILabel *lable;
@end


@implementation collectionCell

-(void)setText:(NSString *)text{
    _text = text;
    
    self.contentView.backgroundColor = [UIColor greenColor];
    
    for(UIView *view in self.contentView.subviews){
        [view removeFromSuperview];
    }
    
    if(!_lable){
        _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 100, 40)];
    }
    _lable.text = text;
    _lable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_lable];
    
}
@end
