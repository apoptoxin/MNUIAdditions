//
//  MNUIImageView.h
//  MNUIAdditions
//
//  Created by 刘楠 on 2018/8/23.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MNUIImageViewAppearingType) {
    MNUIImageViewAppearingTypeNone,
    MNUIImageViewAppearingTypeRotation,
    MNUIImageViewAppearingTypeBlur,
};

@interface MNUIImageView : UIImageView

@property (nonatomic, assign) NSTimeInterval appearingDuration;

- (void)startAppearingWithType:(MNUIImageViewAppearingType)type completion:(dispatch_block_t)completion;
@end
