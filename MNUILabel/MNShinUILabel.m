//
//  MNShinUILabel.m
//  Pods-MNUIAdditions_Example
//
//  Created by 刘楠 on 2018/8/21.
//

#import "MNShinUILabel.h"

@interface MNShinUILabel()

@end

@implementation MNShinUILabel

- (NSMutableAttributedString *)textForCurrentFrame:(CFTimeInterval)timePassed forAppear:(BOOL)forAppear {
    NSMutableAttributedString *result = [self.animationText mutableCopy];
    for (int i = 0; i < result.length; i++) {
        
    }
    return result;
}
@end
