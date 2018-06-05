// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN
@implementation CardView

/// A highet scale for a font drawn in the corner of the card.
static const auto kCornerFontStandardHeight = 180.0;

/// Shrinking the corner offset - the distance between the corner and a drawing in the corner.
static const auto kCornerOffsetShrinkingFactor = 3.0;

/// The desired radius of a card's rounded corner. 
static const auto kCornerRadius = 12.0;

#pragma mark -
#pragma mark UIView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setup];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  [self setup];
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  [self drawContents];
}

#pragma mark -

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (CGFloat)cornerRadius {
  return kCornerRadius * [self cornerScaleFactor];
}

- (CGFloat)cornerScaleFactor {
  return self.bounds.size.height / kCornerFontStandardHeight;
}

- (CGFloat)cornerOffset {
  return [self cornerRadius] / kCornerOffsetShrinkingFactor;
}

// Abstract method.
- (void)drawContents {
  return;
}

@end

NS_ASSUME_NONNULL_END
