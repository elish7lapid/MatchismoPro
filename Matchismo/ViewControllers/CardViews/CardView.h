// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Represents a UIView of a card.
@interface CardView : UIView

/// Draws the card's contents.
- (void)drawContents;

/// The scale factor for the card's rounded corner size. Depends on the current view's size.
- (CGFloat)cornerScaleFactor;

/// The minimal distance drawings should have from the corner. Depends on the current view's size.
- (CGFloat)cornerOffset;

@end

NS_ASSUME_NONNULL_END
