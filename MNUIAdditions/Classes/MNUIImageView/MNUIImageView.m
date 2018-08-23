//
//  MNUIImageView.m
//  MNUIAdditions
//
//  Created by 刘楠 on 2018/8/23.
//

#import "MNUIImageView.h"
#import "MNUIImageUtils.h"

static CGFloat kBlurFactor = 20.0f;
static CGFloat kRotationDistance = 500.0f;

@interface MNUIImageView()
@property (nonatomic, copy) dispatch_block_t completion;
@property (nonatomic, strong) UIImage *backupImage;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) MNUIImageViewAppearingType currentType;
@property (nonatomic, assign) NSTimeInterval startTime;
@end


@implementation MNUIImageView

- (void)startAppearingWithType:(MNUIImageViewAppearingType)type completion:(dispatch_block_t)completion {
    NSAssert(self.appearingDuration > 0.0f, @"appearing duration should not less or equal than zero");
    self.backupImage = self.image;
    [self stopAppearing:NO];
    self.startTime = CACurrentMediaTime();
    _currentType = type;
    switch (type) {
        case MNUIImageViewAppearingTypeBlur:
            [self startBlur];
            break;
        case MNUIImageViewAppearingTypeRotation:
            [self startRotation];
            break;
        default:
            break;
    }
}

#pragma mark - Private Method

- (void)stopAppearing:(BOOL)callCompletion {
    [self resetStatus];
    if (callCompletion && self.completion) {
        self.completion();
    }
    self.completion = nil;
}

- (void)resetStatus {
    self.displayLink.paused = YES;
    self.layer.transform = CATransform3DIdentity;
    self.image = self.backupImage;
}

- (void)startBlur {
    self.image = [MNUIImageUtils blurImageFromOrigin:self.backupImage factor:kBlurFactor];
    self.displayLink.frameInterval = 6;
    self.displayLink.paused = NO;
}

- (void)startRotation {
    [self rotationWithAngle:-M_PI/2];
    self.displayLink.frameInterval = 1;
    self.displayLink.paused = NO;
}

- (void)rotationWithAngle:(CGFloat)angle {
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1/kRotationDistance;
    trans = CATransform3DRotate(trans, angle, 0, 1, 0);
    trans = CATransform3DConcat(trans, CATransform3DMakeTranslation(0,0,-kRotationDistance));
    self.layer.transform = trans;
}

#pragma mark - getter

- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

#pragma mark - selector

- (void)update {
    NSTimeInterval current = CACurrentMediaTime();
    NSTimeInterval minus = MIN(self.appearingDuration, MAX(0.0, current - self.startTime));
    switch (self.currentType) {
        case MNUIImageViewAppearingTypeBlur:
            self.image = [MNUIImageUtils blurImageFromOrigin:self.backupImage factor:kBlurFactor * (1 - (minus / self.appearingDuration))];
            break;
        case MNUIImageViewAppearingTypeRotation:
            [self rotationWithAngle:-M_PI/2 * (1 - (minus / self.appearingDuration))];
            break;
        default:
            break;
    }
    if (minus == self.appearingDuration) {
        [self stopAppearing:YES];
    }
}

@end
