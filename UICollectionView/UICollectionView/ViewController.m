//
//  ViewController.m
//  UICollectionView
//
//  Created by Sure on 15-9-2.
//  Copyright (c) 2015年 Sure. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"//包含自定义Cell文件
#import "MyCollectionReusableView.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 16; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"图书%d",i]];
    }
    
    //collectionViewLayout用于显示CollectionView上的具体内容，并且该内容可以进行自动布局
    //能够布局的类为UICollectionViewLayout
    //需要设置其子类UICollectionViewFlowLayout
    //控制布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置显示形式 1、竖直滑动 2、水平滑动
    /*
     1、UICollectionViewScrollDirectionHorizontal 水平滑动
     2、UICollectionViewScrollDirectionVertical   竖直滑动
     */
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建CollectionView 与布局进行联系
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    //设置协议代理
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    //默认为黑色
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    //注册Collection
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    
    //段头段尾同样需要注册
    //注册段头
    /*
     SupplementaryViewOfKind补充视图的类型
     1、头 UICollectionElementKindSectionHeader
     2、尾 UICollectionElementKindSectionFooter
     */
    [_collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"View"];
    
    //注册段尾
    [_collectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"View"];
    
    //创建CollectionView尽量使用自定义的CollectionViewCell的类型
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark CollectionView所必须实现的方法
//返回段中具有多少Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"10_%ld.jpg",indexPath.item]];
    
    cell.nameLabel.text = self.dataArray[indexPath.item];
    
    return cell;
}
//修改Item的大小 默认50 X 50
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 200);
}
//调整Item的位置 使Item不紧挨着屏幕
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //在原有基础上进行调整 上 左 下 右
    return UIEdgeInsetsMake(10, 10, 0, 0);
}
//设置水平间距与竖直间距 默认为10
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}
//选中方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //可以确定当前的Collection在第几段的第几个Item
    NSLog(@"段:%ld 项:%ld",indexPath.section,indexPath.item);
    
    //CollectionView刷新
    //每点击Item 为数据源增加一条数据
    [self.dataArray addObject:@"新增加的书籍!"];
    
    [_collectionView reloadData];//全局刷新
//    [_collectionView reloadItemsAtIndexPaths:<#(NSArray *)#>]//刷新某一个Item
//    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];//刷新某一段
}
//手动修改段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//修改段的大小(段的高度)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(80, 80);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(80, 80);
}
//修改段头段尾视图
//可以同时修改段头段尾的视图
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //使用
    MyCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"View" forIndexPath:indexPath];
    
    //进行判断 为段头和段尾显示不同的内容
    if (kind == UICollectionElementKindSectionHeader) {
        //布局
        view.myLabel.text = [NSString stringWithFormat:@"段头:%ld段",indexPath.section];
        view.myLabel.backgroundColor = [UIColor blueColor];
        
    }else if (kind == UICollectionElementKindSectionFooter){
    
        view.myLabel.text = [NSString stringWithFormat:@"段尾:%ld段",indexPath.section];
        
        view.myLabel.backgroundColor = [UIColor yellowColor];
    }
    
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
