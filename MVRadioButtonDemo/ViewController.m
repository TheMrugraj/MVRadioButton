//
//  ViewController.m
//  MVRadioButtonDemo
//

//  Copyright (c) 2015 MV. All rights reserved.
//

#import "ViewController.h"
#import "MVRadioButton/MVRadioButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)radioAction:(MVRadioButton*)sender {
    sender.isOn=!sender.isOn;
}

@end
