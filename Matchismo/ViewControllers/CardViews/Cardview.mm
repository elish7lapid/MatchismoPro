// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN
// TODO:(Elisheva)Pragamas.
@implementation CardView

static const auto kCornerFontStandardHeight = 180.0;
static const auto kCornerOffsetShrinkingFactor = 3.0;
static const auto kCornerRadius = 12.0;

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
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
