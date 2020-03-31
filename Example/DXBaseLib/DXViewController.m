//
//  DXViewController.m
//  DXBaseLib
//
//  Created by Jackdx on 03/31/2020.
//  Copyright (c) 2020 Jackdx. All rights reserved.
//

#import "DXViewController.h"
#import <UIAlertController+DX.h>
#import <DXCommonApiStudy.h>

@interface DXViewController ()

@end

@implementation DXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    DXCommonApiStudy *study = [DXCommonApiStudy new];
    [study studyApi];
    
}

- (void)testAlert
{
    [UIAlertController dx_showAlertInViewController:self
                 withTitle:@"Test Alert"
                   message:@"Test Message"
         cancelButtonTitle:@"Cancel"
    destructiveButtonTitle:nil
         otherButtonTitles:@[@"First Other"]
                                           tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (buttonIndex == UIAlertControllerBlocksFirstOtherButtonIndex) {
            NSLog(@"buttonIndex==%ld,title==%@",buttonIndex,action.title);
        }
        
    }];
}

@end
