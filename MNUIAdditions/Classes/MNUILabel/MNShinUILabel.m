//
//  MNShinUILabel.m
//  Pods-MNUIAdditions_Example
//
//  Created by 刘楠 on 2018/8/21.
//

#import "MNShinUILabel.h"

@interface MNShinUILabel()
@property (nonatomic, copy) NSArray *startTimes;
@property (nonatomic, copy) NSArray *durationTimes;
@end

@implementation MNShinUILabel

- (void)startAppearingWithCompletion:(dispatch_block_t)completion {
    [self initialTimesArrayWithMaxDuration:self.appearDuration];
    [super startAppearingWithCompletion:completion];
}

- (void)startFadingWithCompletion:(dispatch_block_t)completion {
    [self initialTimesArrayWithMaxDuration:self.fadeDuration];
    [super startFadingWithCompletion:completion];
}

- (void)initialTimesArrayWithMaxDuration:(CGFloat)maxDuration {
    NSUInteger length = self.animationText.length;
    NSMutableArray *r1 = [NSMutableArray arrayWithCapacity:length];
    NSMutableArray *r2 = [NSMutableArray arrayWithCapacity:length];
    for (int i = 0 ; i < length ; i++) {
        r1[i] = @((arc4random() % 100) / 100.0 * 0.4 * maxDuration);
        CGFloat remain = maxDuration - [r1[i] doubleValue];
        r2[i] = @((arc4random() % 100) / 100.0 * remain);
        
    }
    
    if (length > 5) {
        //随机搞两个最后才出现的
        int first = arc4random() % length;
        int second = arc4random() % length;
        r2[first] = @(maxDuration - [r1[first] doubleValue]);
        r2[second] = @(maxDuration - [r1[second] doubleValue]);
    }
    
    
    self.startTimes = [r1 copy];
    self.durationTimes = [r2 copy];
}

- (NSArray *)caculateDelays:(NSString *)text maxDuration:(CGFloat)maxDuration{
    NSUInteger length = text.length;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:length];
    for (int i = 0 ; i < length ; i++) {
        result[i] = @((arc4random() % 100) / 100.0 * maxDuration);
    }
    return [result copy];
}

- (NSMutableAttributedString *)textForCurrentFrame:(CFTimeInterval)timePassed forAppear:(BOOL)forAppear {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:self.animationText];
    for (int i = 0; i < result.length; i++) {
        CGFloat alpha = MAX(0.0, timePassed - [self.startTimes[i] doubleValue]) / [self.durationTimes[i] doubleValue];
        if (forAppear && timePassed >= self.appearDuration) {
            alpha = 1.0f;
        } else if (!forAppear && timePassed >= self.fadeDuration) {
            alpha = 1.0f;
        }
        [result addAttribute:NSForegroundColorAttributeName value:[self.textColor colorWithAlphaComponent:forAppear?alpha:1-alpha] range:NSMakeRange(i, 1)];
    }
    return result;
}
@end
