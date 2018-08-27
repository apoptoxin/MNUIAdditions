//
//  MNPrinterUILabel.m
//  Pods-MNUIAdditions_Example
//
//  Created by 刘楠 on 2018/8/21.
//

#import "MNPrinterUILabel.h"

@implementation MNPrinterUILabel

- (NSMutableAttributedString *)textForCurrentFrame:(CFTimeInterval)timePassed forAppear:(BOOL)forAppear {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:self.animationText];
    double precent = timePassed / (forAppear ? self.appearDuration : self.fadeDuration);
//    precent = precent > 0.0 ?:0.0;
    int len = (int)((double)result.length * precent);
    if (forAppear) {
        [result addAttribute:NSForegroundColorAttributeName value:[self.animationTextColor colorWithAlphaComponent:forAppear?1.0:0.0] range:NSMakeRange(0, len)];
        [result addAttribute:NSForegroundColorAttributeName value:[self.animationTextColor colorWithAlphaComponent:forAppear?0.0:1.0] range:NSMakeRange(len , result.length - len)];
//        [result removeAttribute:NSBaselineOffsetAttributeName range:NSMakeRange(0, len)];
//        if (len > 0 && len < result.length) {
//            [result addAttribute:NSBaselineOffsetAttributeName value:@(-5) range:NSMakeRange(len-1, 1)];
//        }
    } else {
        [result addAttribute:NSForegroundColorAttributeName value:[self.animationTextColor colorWithAlphaComponent:0.0] range:NSMakeRange(0, len)];
        [result addAttribute:NSForegroundColorAttributeName value:[self.animationTextColor colorWithAlphaComponent:1.0] range:NSMakeRange(len , result.length - len)];
    }
    
    
    return result;
}

@end
