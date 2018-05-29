// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardView : UIView

- (void)drawContents;
- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerOffset;
- (void)setup;

@end

NS_ASSUME_NONNULL_END
