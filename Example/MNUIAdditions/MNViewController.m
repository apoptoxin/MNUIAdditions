//
//  MNViewController.m
//  MNUIAdditions
//
//  Created by 刘楠 on 08/21/2018.
//  Copyright (c) 2018 刘楠. All rights reserved.
//

#import "MNViewController.h"
#import "MNShinUILabel.h"
#import "MNPrinterUILabel.h"

@interface MNViewController ()
@property (nonatomic ,strong) MNAnimatedUILabel* label;
@end

@implementation MNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.label sizeToFit];
    self.label.center = self.view.center;
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.label];
    self.label.textColor = [UIColor whiteColor];
    [self.label startFadingWithCompletion:^{
        [self.label startAppearingWithCompletion:nil];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.label stopAnimating];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MNAnimatedUILabel*)label {
    if (!_label) {
        _label = [[MNPrinterUILabel alloc] init];
        _label.text = @"abcdefghijklmnopqrstuvwxyz";
    }
    return _label;
}

@end
