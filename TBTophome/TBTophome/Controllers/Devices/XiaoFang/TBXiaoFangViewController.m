//
//  TBXiaoFangViewController.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBXiaoFangViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TBAddRemoteConfig.h"

@interface TBXiaoFangViewController ()

@property (weak, nonatomic) IBOutlet UIButton *add;

@end

@implementation TBXiaoFangViewController

- (void)bindAction {
    @weakify(self)
    [[self.add rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
         TBAddRemoteConfig.xiaofang_uid = self.device.device.uid;
         TBAddRemoteConfig.xiaofang_deviceId = self.device.device.deviceId;
         Class cl = NSClassFromString(@"TBRemotesTypeViewController");
         UIViewController *vc = [cl performSelector:NSSelectorFromString(@"instanceRemotesTypeViewController") withObject: nil];
         [self showViewController:vc sender:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bindAction];
    
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
