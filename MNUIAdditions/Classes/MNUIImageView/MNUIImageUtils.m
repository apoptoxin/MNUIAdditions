//
//  MNUIImageUtils.m
//  MNUIAdditions
//
//  Created by 刘楠 on 2018/8/23.
//

#import "MNUIImageUtils.h"

@implementation MNUIImageUtils

+ (UIImage *)blurImageFromOrigin:(UIImage *)origin factor:(CGFloat)factor {
    @autoreleasepool {
        CIImage *imageToBlur = [CIImage imageWithCGImage:origin.CGImage];
        
        CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
        [gaussianBlurFilter setValue:imageToBlur forKey: kCIInputImageKey];
        [gaussianBlurFilter setValue:[NSNumber numberWithFloat:factor] forKey: kCIInputRadiusKey];
        
        CIFilter *cropFilter = [CIFilter filterWithName:@"CICrop"];
        [cropFilter setValue:[gaussianBlurFilter valueForKey:kCIOutputImageKey] forKey:kCIInputImageKey];
        [cropFilter setValue:[CIVector vectorWithCGRect:imageToBlur.extent] forKey:@"inputRectangle"];
        
        CIImage *resultImage = [cropFilter valueForKey: kCIOutputImageKey];
        return [[UIImage alloc] initWithCIImage:resultImage];
    }
}

@end
