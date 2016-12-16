//
//  MCLeftSortsViewController.h
//  LeftSlide
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 machao. All rights reserved.
//

#import "MCLeftSortsViewController.h"
#import "MCLeftSliderManager.h"
#import "MCOtherViewController.h"
#import "DKNightVersion.h"
#import "LoginViewController.h"
#import "UsersManager.h"
#import "UIViewController+AlertTittle.h"
#import "RegisterViewController.h"
@interface MCLeftSortsViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@end

@implementation MCLeftSortsViewController{
    UILabel *_label;
    UIImageView *_HeaderImage;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor redColor];
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableview = tableview;

    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    
  
//    UISwitch *lightButton = [UISwitch new];
//    lightButton.frame = CGRectMake((kScreenWidth - kMainPageDistance)/2 +100, kScreenHeight - 50, 200, 44);
//    [lightButton addTarget:self action:@selector(changeLight) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:lightButton];
    // 设置夜间效果的颜色
    @weakify(self);
    [self addColorChangedBlock:^{
        @strongify(self);
        self.view.normalBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leftbackiamge"]];
        self.view.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.tableview.normalBackgroundColor = [UIColor clearColor];
        self.tableview.nightBackgroundColor = UIColorFromRGB(0x343434);
        self.tableview.nightSeparatorColor = UIColorFromRGB(0x313131);
        self.navigationController.navigationBar.nightBarTintColor = UIColorFromRGB(0x444444);
        self.navigationItem.leftBarButtonItem.nightTintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem.nightTintColor = [UIColor whiteColor];
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BOOL flag=[[UsersManager shareInstance]NullEfficacy];
    if (flag) {
        
        _label.text=[[UsersManager shareInstance]queryUserInfo].userName ;
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(void)configHeadView:(UIImage *)imageName :(NSString *)name{
    _HeaderImage.image=imageName;
    _label.text=name;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view=[[UIView alloc]init];

    UIImageView *HeaderImage = [[UIImageView alloc]init];
    HeaderImage.frame = CGRectMake(self.view.width * (0.5-0.17)/2.0, 20, self.view.width * 0.17, self.view.width * 0.17);
    HeaderImage.image = [UIImage imageNamed:@"default_head"];
    HeaderImage.contentMode = UIViewContentModeScaleAspectFit;
    HeaderImage.layer.cornerRadius = self.view.width * 0.17 * 0.5;
    HeaderImage.layer.masksToBounds = YES;
    HeaderImage.userInteractionEnabled=YES;
    _HeaderImage=HeaderImage;
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personCenter:)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [HeaderImage addGestureRecognizer:singleRecognizer];
    
    [view addSubview:HeaderImage];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.width * 0.17+22, self.view.width/2 , 30)];
    _label=label;
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor lightTextColor];
    BOOL flag=[[UsersManager shareInstance]NullEfficacy];
    if (flag) {
        
        _label.text=[[UsersManager shareInstance]queryUserInfo].userName ;
        
    }
    else
        label.text=@"请登录";
    
    label.userInteractionEnabled=YES;
    [view addSubview:label];

    UITapGestureRecognizer* singleRecognizer1;
    singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginIndex:)];
    //点击的次数
    singleRecognizer1.numberOfTapsRequired = 1; // 单击
    [label addGestureRecognizer:singleRecognizer1];
    
    return view;

}


-(void)loginIndex:(UIPanGestureRecognizer*)sender{
   BOOL loginStus= [[UsersManager shareInstance] NullEfficacy] ;
    
    
    
    if (loginStus) {
        MCOtherViewController *vc = [[MCOtherViewController alloc] init];
        
        vc.titleName = @"个人中心";
        [[MCLeftSliderManager sharedInstance].LeftSlideVC closeLeftView];
        //关闭左侧抽屉
        [vc setHidesBottomBarWhenPushed:YES];
        [[MCLeftSliderManager sharedInstance].mainNavigationController pushViewController:vc animated:NO];
    }
    else{
        __weak __typeof(self)weakSelf = self;
        [self AlertDoubleButtonTittle:@"提示信息" Message:@"您还未登录" OneBtnTittle:@"取消" OtherBtnTittle:@"登录" block1:^{
            
            
        } block2:^{
            
            RegisterViewController *vc=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil
                                        ];
            [weakSelf presentViewController:vc animated:YES completion:nil];
            

            
        }];
  
    }
    
    

}


-(void)personCenter:(UIPanGestureRecognizer*)sender{
    MCOtherViewController *vc = [[MCOtherViewController alloc] init];
    
    vc.titleName = @"个人中心";
    [[MCLeftSliderManager sharedInstance].LeftSlideVC closeLeftView];
    //关闭左侧抽屉
    [vc setHidesBottomBarWhenPushed:YES];
    [[MCLeftSliderManager sharedInstance].mainNavigationController pushViewController:vc animated:NO];

}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{

   return  self.view.width * 0.17+20+35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:19.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"我的文件";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MCOtherViewController *vc = [[MCOtherViewController alloc] init];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.titleName = cell.textLabel.text;
    [[MCLeftSliderManager sharedInstance].LeftSlideVC closeLeftView];//关闭左侧抽屉
    [vc setHidesBottomBarWhenPushed:YES];
    [[MCLeftSliderManager sharedInstance].mainNavigationController pushViewController:vc animated:NO];

}



-(void)changeLight{
    NSLog(@"daindad");
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }
}

@end
