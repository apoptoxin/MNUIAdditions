//
//  MNAnimatedUILabel.h
//  Pods-MNUIAdditions_Example
//
//  Created by 刘楠 on 2018/8/21.
//

#import <UIKit/UIKit.h>

@interface MNAnimatedUILabel : UILabel
@property (assign) CFTimeInterval appearDuration;
@property (assign) CFTimeInterval fadeDuration;
@property (nonatomic, assign) BOOL autoAppear;

@property (nonatomic, strong, readonly) NSAttributedString *animationText;
@property (nonatomic, assign, readonly, getter=isAnimating) BOOL animating;

- (void)startAppearingWithCompletion:(dispatch_block_t)completion;
- (void)startFadingWithCompletion:(dispatch_block_t)completion;
- (void)stopAnimating;
// 子类重写
- (NSMutableAttributedString *)textForCurrentFrame:(CFTimeInterval)timePassed forAppear:(BOOL)forAppear;
@end
