//
//  JHHomeViewController.m
//  MallProject
//
//  Created by 江湖 on 2019/6/3.
//  Copyright © 2019 江湖. All rights reserved.
//

#import "JHHomeViewController.h"
#import "JHHomeModel.h"
#import "NewPagedFlowView.h"
#import "JHHomeBannerCell.h"
#import "JHHomeRowCell.h"
#import "UINavigationBar+NavBackGroudColor.h"
#define HomeNavHeight 50
@interface JHHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong)JHHomeModel *homeModel;

@property(nonatomic, assign) CGFloat offsetY;

@end

@implementation JHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JHHomeBannerCell" bundle:nil] forCellWithReuseIdentifier:bannerCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JHHomeRowCell" bundle:nil] forCellWithReuseIdentifier:productCellID];

    [self loadDatas];
    UITextField *textfile = [[UITextField alloc]initWithFrame:CGRectMake(0, 6, ScreenW-140, 32)];
    textfile.borderStyle = UITextBorderStyleRoundedRect;
    textfile.placeholder = @"请输入搜索的商品";
    self.navigationItem.titleView = textfile;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.translucent = YES;
    UIColor * color = JHColorA(250, 71, 76, 1);
    CGFloat offsetY = self.offsetY;
    //改变导航栏的背景色
    [self changeNavBackColorWithColor:color Offset:offsetY];
//
//    if (self.isNeedToUpdaData) {
//        //请求数据
//        [self loadData:NO];
//    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    });
}

//根据滚动的距离改变偏移量
-(void)changeNavBackColorWithColor:(UIColor *)color Offset:(CGFloat)offsetY{
    
    
    if (offsetY > HomeNavHeight ) {
        
        CGFloat alpha = MIN(1, 1 - ((HomeNavHeight + JHNavHeight * 2 - offsetY) / JHNavHeight));
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        //        if (alpha >= 0.5) {
        //            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        //        }else{
        //            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        //        }
        
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}
- (void)loadDatas{
    NSString *url = [NSString stringWithFormat:@"%@%@",httpUrl,@"Home/MIndex"];
    [self.parameter setObject:@"" forKey:@"userID"];
    KWeakSelf(self);
    [JHNetWorking shareInstance].post(url,self.parameter).showhud(YES).success(^(NSDictionary *dict, BOOL successful, JHError *error) {
        if (successful) {
            JHHomeModel *homeModel = [JHHomeModel mj_objectWithKeyValues:dict];
            [homeModel setingSectionDatas:homeModel];
            weakself.homeModel = homeModel;
            [weakself.collectionView reloadData];
        }else {

        }
    }).failure(^(NSError *error) {

    });
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    JHDataModel *model = self.homeModel.sectionArray[section];
    return model.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.homeModel.sectionArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    JHDataModel *model = self.homeModel.sectionArray[indexPath.section];
    return model.itemSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JHDataModel *model = self.homeModel.sectionArray[indexPath.section];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:model.cellID forIndexPath:indexPath];
    if (model.itemType == JHDataModelType1) {
        ((JHHomeBannerCell *)cell).pagedView.delegate = self;
        ((JHHomeBannerCell *)cell).pagedView.dataSource = self;
        ((JHHomeBannerCell *)cell).imageArray = model.GroupArray;


    }else if (model.itemType == JHDataModelType2){
        
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    JHDataModel *model = self.homeModel.sectionArray[section];
    return model.headerSize;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    JHDataModel *model = self.homeModel.sectionArray[section];
    return model.footerSize;
}

#pragma mark--UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor * color = JHColorA(250, 71, 76, 1);
    CGFloat offsetY = scrollView.contentOffset.y;
    
    [self changeNavBackColorWithColor:color Offset:offsetY];
    
    self.offsetY = offsetY;

//    if (offsetY < -JHNavHeight) {
//        [self updateNavigationBarUIWithIsHide:YES];
//    } else {
//        [self updateNavigationBarUIWithIsHide:NO];
//    }
}

#pragma mark NewPagedFlowView Delegate
#pragma mark =========点击了第几页=========
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}
#pragma mark =========滚动到了第几页=========
- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%d页",pageNumber);
}
@end
