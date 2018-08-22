//
//  MNPrinterUILabel.m
//  Pods-MNUIAdditions_Example
//
//  Created by 刘楠 on 2018/8/21.
//

#import "MNPrinterUILabel.h"

@implementation MNPrinterUILabel

- (NSMutableAttributedString *)textForCurrentFrame:(CFTimeInterval)timePassed forAppear:(BOOL)forAppear {
    NSMutableAttributedString *result = [self.animationText mutableCopy];
    double precent = timePassed / (forAppear ? self.appearDuration : self.fadeDuration);
//    precent = precent > 0.0 ?:0.0;
    int len = (int)((double)result.length * precent);
    [result addAttribute:NSForegroundColorAttributeName value:[self.textColor colorWithAlphaComponent:forAppear?1.0:0.0] range:NSMakeRange(0, len)];
    [result addAttribute:NSForegroundColorAttributeName value:[self.textColor colorWithAlphaComponent:forAppear?0.0:1.0] range:NSMakeRange(len , result.length - len)];
    
    return result;
}

@end
