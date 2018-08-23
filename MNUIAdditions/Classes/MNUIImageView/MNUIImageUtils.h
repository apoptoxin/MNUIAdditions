//
//  MNUIImageUtils.h
//  MNUIAdditions
//
//  Created by 刘楠 on 2018/8/23.
//

#import <Foundation/Foundation.h>

@interface MNUIImageUtils : NSObject
+ (UIImage *)blurImageFromOrigin:(UIImage *)origin factor:(CGFloat)factor;
@end
