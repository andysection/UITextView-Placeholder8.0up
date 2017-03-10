//
//  ViewController.m
//  UITextView-PlaceHolder8.0
//
//  Created by admin on 17/3/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+Placeholder.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = [UIColor greenColor];
    [textView was_setPlaceholderWithText:@"1234" Color:[UIColor grayColor]];
    textView.font = [UIFont systemFontOfSize:30];
    
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
