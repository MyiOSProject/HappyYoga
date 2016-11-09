//
//  HYWizardViewController.m
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#import "HYWizardViewController.h"
#import "HYLoginViewController.h"

@interface HYWizardViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation HYWizardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个scrollView，显示所有新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    
    for (int i = 0; i < HYNewfeatureCount; i++ ) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * scrollW;
        imageView.y = 0;
        
        // 显示图片new_feature_4
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        // 最后一个imageView，向里面添加内容
        if (i == HYNewfeatureCount -1) {
            [self setupLastImageView:imageView];
        }
    }
    
    //  设置scrollView的其他属性
    scrollView.contentSize = CGSizeMake(HYNewfeatureCount *scrollW, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    scrollView.backgroundColor = [UIColor yellowColor];
    
    // 添加pageControl 分页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = HYNewfeatureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor =HYColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = HYColor(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    pageControl.backgroundColor = [UIColor blueColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
}

/*
 *   给最后一张 图片 添加 按钮
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 分享
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    //开始使用
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    
    [startBtn setTitle:@"开始使用" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}

- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

/**
 *  开始使用，进入登录页面
 */
- (void)startClick
{
    HYGlobalParams *gParams = [HYGlobalParams sharedInstance];
    gParams.firstUse = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HY_NOTIFICATION_WIZARD_DISMISSED object:nil];
    
    [_delegate wizardDidDismiss];
}

- (void)dealloc
{
    HYLog(@"YBNewfeatureViewControllerdealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
