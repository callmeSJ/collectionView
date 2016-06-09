//
//  ViewController.m
//  collectionView
//
//  Created by SJ on 16/6/9.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "ViewController.h"
#import "collectionCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property(nonatomic,strong)NSMutableArray *collectionArray;
@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createCollectionView];
    [self initCollectionData];
    
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(180, 120);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    layout.footerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, 100);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[collectionCell class] forCellWithReuseIdentifier:@"collection"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeader"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collectionFooter"];
    
    [self.view addSubview:_collectionView];
    
}

-(void)initCollectionData{
    _collectionArray = [NSMutableArray array];
    for(int i = 0; i < 10; i++){
        [_collectionArray addObject:[NSString stringWithFormat:@"collection%d",i]];
        
    }
    [_collectionView reloadData];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _collectionArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    collectionCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    if(!cell){
        cell = [[collectionCell alloc]init];
        
    }
    cell.text = _collectionArray[indexPath.row];
    return cell;
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *headView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionHeader" forIndexPath:indexPath];
        
        if(headView == nil){
            headView = [[UICollectionReusableView alloc]init];
            
        }else{
            for(UIView *view in headView.subviews){
                [view removeFromSuperview];
                
            }
            
        }
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        lable.backgroundColor = [UIColor yellowColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = [NSString stringWithFormat:@"section%ld的头视图",indexPath.section];
        
        [headView addSubview:lable];
        return  headView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"collectionFooter" forIndexPath:indexPath];
        
        if(footView == nil){
            footView = [[UICollectionReusableView alloc]init];
            
        }else{
            for(UIView *view in footView.subviews){
                [view removeFromSuperview];
            }
        }
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        lable.backgroundColor = [UIColor blueColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = [NSString stringWithFormat:@"section%ld的尾视图",indexPath.section];
        [footView addSubview:lable];
        
        return footView;
        
    }
    
    return  nil;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //这个代理方法是当你选择一个Cell之后会触发
    
    collectionCell *cell = (collectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //这个方法可以取到对应的Cell，TableView也可以使用，由于Collection的Cell没有SelectStyle这个属性，所以可以用这种方式模拟选中状态
    cell.contentView.backgroundColor = [UIColor redColor];
    NSLog(@"选择%@",_collectionArray[indexPath.row]);
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //这个代理方法是当你取消选择一个Cell之后会触发
    collectionCell *cell = (collectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor greenColor];
    NSLog(@"取消选择%@",_collectionArray[indexPath.row]);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
