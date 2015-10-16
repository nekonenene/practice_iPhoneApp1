//
//  ViewController.m
//  sampleBmi
//
//  Created by Yokoe on 10/16/15.
//  Copyright © 2015 HANAUTA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// Return キーが押された時に、ソフトウェアキーボードをしまう
- (BOOL)textFieldCatchReturn :(UITextField *)targetTextField
{
    [targetTextField resignFirstResponder] ;
    return 1 ; // YES
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bmiTextLabel.hidden = YES ;
    resultValueLabel.hidden = YES ;
    resultTextLabel.hidden = YES ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
