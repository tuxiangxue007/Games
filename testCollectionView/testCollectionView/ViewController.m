//
//  ViewController.m
//  testCollectionView
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018年 DAA. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+WebCache.h>

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSArray *imgData;
}

@end


@implementation ViewController

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *s = @"首先第一个要说的就是西蒙<em>斯</em>了,第三个要说的就是<em>詹</em><em>姆</em><em>斯</em>了";
    NSMutableArray *mArr = [NSMutableArray array];
    NSArray *arr = [s componentsSeparatedByString:@"</em>"];
    
    for (int index = 0; index < arr.count; index ++) {
        NSString *str = arr[index];
        NSArray *arr1 = [str componentsSeparatedByString:@"<em>"];
        if (arr1.count > 1) {
            NSString *obj = arr1.lastObject;
            int loc = 0;
            for (int j = 0; j < index; j ++) {
                loc += (((NSString *)arr[j]).length + 5);
            }
            NSRange range = NSMakeRange(loc + ((NSString *)arr1.firstObject).length + 4, obj.length);
            NSLog(@"%@ -- %ld-%ld",obj,range.location,range.length);
            NSLog(@"%@",[s substringWithRange:range]);
            [mArr addObject:@{@"str":obj,@"loc":[NSNumber numberWithInteger:range.location],@"len":[NSNumber numberWithInteger:range.length]}];
        }
    }
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:s];
    for (int i = 0; i < mArr.count; i ++) {
        NSDictionary *d = mArr[i];
        [att setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange([d[@"loc"] integerValue], [d[@"len"] integerValue])];
    }
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 600, 200)];
    lab.numberOfLines = 0;
    lab.attributedText = att;
    [self.view addSubview:lab];
    
    
    return;
    imgData = @[@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg"],
                @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg",
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1540463107526&di=b17538785436e5ba2b6a1f8ac350408e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F7acb0a46f21fbe09334115c061600c338644adc3.jpg"]
                ];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(110, 150);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    
    [mDict setDictionary:@{@"key1":@"1"}];
    NSLog(@"%@",mDict);
    [mDict setValuesForKeysWithDictionary:@{@"key2":@"2"}];
//    [mDict setDictionary:@{@"key2":@"2"}];
    NSLog(@"%@",mDict);

}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
//    if (!cell) {
//        cell = [UICollectionViewCell alloc]init
//    }
//    cell.botlabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
    
    for (UIView *item in cell.contentView.subviews) {
        [item removeFromSuperview];
    }
    NSString *imgUrl = imgData[indexPath.section][indexPath.row];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.bounds];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl]
               placeholderImage:[UIImage imageNamed:@""]
                        options:SDWebImageRefreshCached];
    
    [cell.contentView addSubview:imgView];
    
    
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 130);
}



//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
