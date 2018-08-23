//
//  MNAnimatedUILabel.m
//  Pods-MNUIAdditions_Example
//
//  Created by 刘楠 on 2018/8/21.
//

#import "MNAnimatedUILabel.h"

@interface MNAnimatedUILabel()
@property (nonatomic, strong, readwrite) NSString *animationText;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval startTimeInterval;
@property (nonatomic, copy) dispatch_block_t completion;
@property (nonatomic, assign, readwrite) BOOL animating;
@property (nonatomic, assign) BOOL appearing;
@end

@implementation MNAnimatedUILabel

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self defaultInit];
    }
    return self;
}

- (void)dealloc {
    [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)defaultInit {
    self.appearDuration = 2.5f;
    self.fadeDuration = 2.5f;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAppearance)];
    _displayLink.paused = YES;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (NSMutableAttributedString *)textForCurrentFrame:(CFTimeInterval)timePassed forAppear:(BOOL)forAppear {
    return [[NSMutableAttributedString alloc] initWithString:self.text];
}

#pragma mark - Public Method

- (void)startAppearingWithCompletion:(dispatch_block_t)completion {
    self.attributedText = [self initialAnimationTextWithOriginText:self.animationText];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimationWithCompletion:completion appearing:YES];
    });
}

- (void)startFadingWithCompletion:(dispatch_block_t)completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startAnimationWithCompletion:completion appearing:NO];
    });
}

- (void)stopAnimating {
    [self stopAnimation:NO];
}

#pragma mark - Private Method

- (void)startAnimationWithCompletion:(dispatch_block_t)completion appearing:(BOOL)appearing{
    if (self.isAnimating) {
        return;
    }
    
    self.displayLink.paused = YES;
    self.completion = completion;
    self.startTimeInterval = CACurrentMediaTime();
    self.animating = YES;
    self.appearing = appearing;
    self.displayLink.paused = NO;
}

- (void)stopAnimation:(BOOL)callCompletionBlock {
    self.displayLink.paused = YES;
    self.animating = NO;
    if (callCompletionBlock && self.completion) {
        self.completion();
    }
    self.completion = nil;
}

- (NSAttributedString *)initialAnimationTextWithOriginText:(NSString *)text {
    NSMutableAttributedString* newText = [[NSMutableAttributedString alloc] initWithString:text];
    [newText addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, text.length)];
    return [newText copy];
}

#pragma mark - getter and setter

- (void)setAutoAppear:(BOOL)autoAppear {
    
}

- (void)setText:(NSString *)text {
    self.animationText = [text copy];
    NSAttributedString *a = [self initialAnimationTextWithOriginText:text];
    self.attributedText = a;
}

#pragma mark - selector
- (void)updateAppearance {
    CFTimeInterval current = CACurrentMediaTime();
    CFTimeInterval minus = current - self.startTimeInterval;

    self.attributedText = [[self textForCurrentFrame:MIN(MAX(0.0, minus), (self.appearing ? self.appearDuration : self.fadeDuration)) forAppear:self.appearing] copy];
    
    if (self.animating && self.appearing && minus > self.appearDuration) {
        [self stopAnimation:YES];
    }
    
    if (self.animating && !self.appearing && minus > self.fadeDuration) {
        [self stopAnimation:YES];
    }
    
}

@end
