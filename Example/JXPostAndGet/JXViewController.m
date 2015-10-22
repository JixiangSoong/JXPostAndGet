//
//  JXViewController.m
//  JXPostAndGet
//
//  Created by Jack Soong on 10/21/2015.
//  Copyright (c) 2015 Jack Soong. All rights reserved.
//

#import "JXViewController.h"
#import "ApiCall.h"

@interface JXViewController ()

@end

@implementation JXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[ApiCall defaultApiCal] getResponse:@"http://apis.juhe.cn/mobile/get?phone=18016388453&key=b4b88a8ffc09e2fd3f24251ee19fa168"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
