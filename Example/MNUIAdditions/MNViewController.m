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
#import "MNUIImageView.h"

@interface MNViewController ()
@property (nonatomic, strong) MNAnimatedUILabel* label;
@property (nonatomic, strong) MNUIImageView *imageView;
@end

@implementation MNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.label sizeToFit];
    self.label.center = self.view.center;
//    self.view.backgroundColor = [UIColor greenColor];
    UIImage *image1 = [UIImage imageNamed:@"test1"];
    UIImage *image2 = [UIImage imageNamed:@"test2"];
    UIImage *image3 = [UIImage imageNamed:@"test3"];
//    self.imageView.animationImages = @[image1,image2,image3];
//    self.imageView.animationDuration = 2.5f;
    self.imageView.image = image1;
    self.imageView.frame = self.view.bounds;
    [self.view addSubview:self.imageView];
    self.imageView.appearingDuration = 10.5f;
//    [self.imageView startAppearingWithType:MNUIImageViewAppearingTypeRotation completion:nil];
    [self.view addSubview:self.label];
    self.label.textColor = [UIColor blackColor];
    [self.label startAppearingWithCompletion:^{
        [self.label startFadingWithCompletion:nil];
    }];
    
    NSMutableAttributedString* newText = [[NSMutableAttributedString alloc] initWithString:@"abcfdsds"];
    [newText addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, newText.string.length)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 0, 0)];
    label.textColor = [UIColor blackColor];
    label.attributedText = newText;
    [label sizeToFit];
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MNAnimatedUILabel*)label {
    if (!_label) {
        _label = [[MNShinUILabel alloc] init];
        _label.text = @"abcdefghijklmnopqrstuvwxyz";
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:60];
    CGSize size = [_label.text sizeWithFont:_label.font constrainedToSize:CGSizeMake(self.view.frame.size.width - 50.0f,10000.0f)lineBreakMode:UILineBreakModeWordWrap];
        _label.frame = CGRectMake(0, 0, size.width, size.height);
        
    }
    return _label;
}

- (MNUIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[MNUIImageView alloc] init];
    }
    return _imageView;
}

@end
