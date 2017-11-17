//
//  TBPersonalCenterViewController.m
//  TBTophome
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import "TBPersonalCenterViewController.h"
#import "UIViewController+NavigationItemTitle.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TBPersonalCenterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *portrait;
@property (weak, nonatomic) IBOutlet UILabel *buildVersion;
@property (weak, nonatomic) IBOutlet UILabel *nickname;

@end

@implementation TBPersonalCenterViewController

- (void)bindAction {
    @weakify(self)
    [[[self.portrait rac_signalForControlEvents:UIControlEventTouchUpInside]
      takeUntil:[self rac_willDeallocSignal]]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         Class cl = NSClassFromString(@"TBAccountViewController");
         UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceViewController") withObject: nil];
         [self showViewController:vc sender:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = LFLocalizableString(@"My Center", nil);
    [self bindAction];
    
    self.buildVersion.text = [NSString stringWithFormat:@"%@：%@", LFLocalizableString(@"Current version", nil), [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.nickname.text = userAccout().currentAccount.userName;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)instanceViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalCenter" bundle:nil];
    return [sb instantiateInitialViewController];
}

@end
