//
//  ViewController.m
//  qqqq
//
//  Created by 云媒 on 17/3/22.
//  Copyright © 2017年 YunMei. All rights reserved.
//

#import "ViewController.h"
#import "SGScanningQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    
}

- (IBAction)ww:(UIButton *)sender {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                   
                        SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
                        [self presentViewController:scanningQRCodeVC animated:YES completion:nil];
                        scanningQRCodeVC.ResulestBlock = ^(NSString *resulet){
                            if (resulet) {
                                NSLog(@"1%@",resulet);
                            }
                        };
                        
                    }
            }];
    }else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
        SGScanningQRCodeVC *scanningQRCodeVC = [[SGScanningQRCodeVC alloc] init];
        
        [self presentViewController:scanningQRCodeVC animated:YES completion:nil];
        scanningQRCodeVC.ResulestBlock = ^(NSString *resulet){
            
            if (resulet) {
               NSLog(@"2%@",resulet);
            }
        };
    
    }
    else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"请去-> [设置 - 隐私 - 相机 - 云媒云仓储应用] 打开访问开关" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
    } else if (status == AVAuthorizationStatusRestricted) {
        NSLog(@"因为系统原因, 无法访问相册");
    }
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"未检测到您的摄像头, 请在真机上测试" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        
        [alertView show];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
