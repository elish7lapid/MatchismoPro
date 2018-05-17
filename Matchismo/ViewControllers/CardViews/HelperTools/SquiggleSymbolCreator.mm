// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SquiggleSymbolCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SquiggleSymbolCreator

static const auto kBasicSquiggleHeight = 58.7;
static const auto kBasicSquiggelWidth = 107.8;

- (void)createInContext:(CGContextRef)context {
  CGContextMoveToPoint(context, 104.0, 15.0);
  CGContextAddCurveToPoint( context, 112.4 , 36.9,   89.7,  60.8,   63.0,  54.0 );
  CGContextAddCurveToPoint( context,  52.3 , 51.3,   42.2,  42.0,   27.0,  53.0 );
  CGContextAddCurveToPoint( context,   9.6 , 65.6,    5.4,  58.3,    5.0,  40.0 );
  CGContextAddCurveToPoint( context,   4.6 , 22.0,   19.1,   9.7,   36.0,  12.0 );
  CGContextAddCurveToPoint( context,  59.2 , 15.2,   61.9,  31.5,   89.0,  14.0 );
  CGContextAddCurveToPoint( context,  95.3 , 10.0,  100.9,   6.9,  104.0,  15.0 );
}

- (CGFloat)scaleForWidth:(CGFloat)width andHeight:(CGFloat)height {
  auto xScale = width / kBasicSquiggelWidth;
  auto yScale = height / kBasicSquiggleHeight;
  return fmin(xScale, yScale);
}

@end

NS_ASSUME_NONNULL_END
