//
//  ViewController.m
//  KMKeyChainKitDemo
//
//  Created by Mioke on 1/26/16.
//  Copyright © 2016 Mioke. All rights reserved.
//

#import "ViewController.h"
#import "KMKeyChainKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KMKeyChainKit *kit = [[KMKeyChainKit alloc] init];
    
    // add
    [kit saveValue:@"pwd12345" forIdentifier:@"username"];
    NSLog(@"%@", [kit getValueWithIdentifier:@"username"]);
    // change
    [kit updateValue:@"pwd54321" forIdentifier:@"username"];
    NSLog(@"%@", [kit getValueWithIdentifier:@"username"]);
    // delete
    [kit deleteValueWithIdentifier:@"username"];
    NSLog(@"%@", [kit getValueWithIdentifier:@"username"]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
