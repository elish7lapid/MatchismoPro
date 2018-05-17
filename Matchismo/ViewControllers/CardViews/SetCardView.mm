// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()
@property (nonatomic) CGFloat symbolScaleFactor;
@end

@implementation SetCardView

@synthesize symbolScaleFactor = _symbolScaleFactor;

static const auto kBasicSquiggleHeight = 58.7;
static const auto kBasicSquiggelWidth= 107.8;
static const auto kDefaultSymbolScaleFactor = 0.70;
static const NSUInteger kMaxNumSymbols = 3;

- (void)drawContents {
  CGContextRef context = UIGraphicsGetCurrentContext();
  auto scale = [self getSquiggleScale];
  CGContextScaleCTM(context, scale, scale);
  CGContextTranslateCTM(context, 0, 0);
  [self createSquiggleInContext:context];
  CGContextTranslateCTM(context, 10, 10);
  [self createSquiggleInContext:context];
  // draw the squiggle
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, 2.0 );
  CGContextStrokePath(context);
  
}

- (void)createSquiggleInContext:(CGContextRef)context {
  CGContextMoveToPoint(context, 104.0, 15.0);
  CGContextAddCurveToPoint( context, 112.4 , 36.9,   89.7,  60.8,   63.0,  54.0 );
  CGContextAddCurveToPoint( context,  52.3 , 51.3,   42.2,  42.0,   27.0,  53.0 );
  CGContextAddCurveToPoint( context,   9.6 , 65.6,    5.4,  58.3,    5.0,  40.0 );
  CGContextAddCurveToPoint( context,   4.6 , 22.0,   19.1,   9.7,   36.0,  12.0 );
  CGContextAddCurveToPoint( context,  59.2 , 15.2,   61.9,  31.5,   89.0,  14.0 );
  CGContextAddCurveToPoint( context,  95.3 , 10.0,  100.9,   6.9,  104.0,  15.0 );
}

- (CGFloat)getSquiggleScale {
  auto desiredWidth = self.bounds.size.width * self.symbolScaleFactor;
  auto desiredHeight = (self.bounds.size.height / self.numSymbols) * self.symbolScaleFactor;
  auto xScale = desiredWidth / kBasicSquiggelWidth;
  auto yScale = desiredHeight / kBasicSquiggleHeight;
  return fmin(xScale, yScale);
}

- (void)setSymbol:(ContentsSymbol)symbol {
  if (_symbol == symbol) {
    return;
  }
  _symbol = symbol;
  [self setNeedsDisplay];
}

- (void)setNumSymbols:(NSInteger)numSymbols {
  if (_numSymbols == numSymbols) {
    return;
  }
  _numSymbols = numSymbols;
  [self setNeedsDisplay];
}

- (void)setSymbolColor:(UIColor *)symbolColor {
  if (_symbolColor == symbolColor) {
    return;
  }
  _symbolColor = symbolColor;
  [self setNeedsDisplay];
}

- (void)setFillPattern:(ContentsFillPattern)fillPattern {
  if (_fillPattern == fillPattern) {
    return;
  }
  _fillPattern = fillPattern;
  [self setNeedsDisplay];
}

- (void)setSymbolScaleFactor:(CGFloat)symbolScaleFactor {
  if (_symbolScaleFactor == symbolScaleFactor) {
    return;
  }
  _symbolScaleFactor = symbolScaleFactor;
  [self setNeedsDisplay];
}

- (CGFloat)symbolScaleFactor {
  if (_symbolScaleFactor == 0) {
    _symbolScaleFactor = kDefaultSymbolScaleFactor;
  }
  return _symbolScaleFactor;
}
@end

NS_ASSUME_NONNULL_END
