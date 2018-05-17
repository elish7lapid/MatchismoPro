// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()
@property (nonatomic) CGFloat symbolScaleFactor;
@end

@implementation SetCardView

static const auto kDefaultSymbolScaleFactor = 0.10;

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    _symbolScaleFactor = kDefaultSymbolScaleFactor;
  }
  return self;
}

- (void)drawContents {
  CGRect emptyRect = CGRectInset(self.bounds, self.bounds.size.width * self.symbolScaleFactor,
                                 self.bounds.size.height * self.symbolScaleFactor);
  UIBezierPath *contentsRect = [UIBezierPath bezierPathWithRect:emptyRect];
  
  [contentsRect addClip];
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [self drawSquiggle];
  
}

- (void)drawSquiggle
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  // translate and scale the squiggle
  CGContextSaveGState( context );
  CGContextTranslateCTM( context, 0, 100 );
  CGContextScaleCTM( context, 2.0, 2.0 );
  
  // create the squiggle path
  CGContextMoveToPoint(context, 104.0, 15.0 );
  CGContextAddCurveToPoint(context, 112.4 , 36.9,   89.7,  60.8,   63.0,  54.0 );
  CGContextAddCurveToPoint(context,  52.3 , 51.3,   42.2,  42.0,   27.0,  53.0 );
  CGContextAddCurveToPoint(context,   9.6 , 65.6,    5.4,  58.3,    5.0,  40.0 );
  CGContextAddCurveToPoint(context,   4.6 , 22.0,   19.1,   9.7,   36.0,  12.0 );
  CGContextAddCurveToPoint(context,  59.2 , 15.2,   61.9,  31.5,   89.0,  14.0 );
  CGContextAddCurveToPoint(context,  95.3 , 10.0,  100.9,   6.9,  104.0,  15.0 );
  
  // draw the squiggle
  CGContextSetLineCap(context, kCGLineCapRound );
  CGContextSetLineWidth(context, 2.0 );
  CGContextStrokePath(context );
  
  // restore the graphics state
  CGContextRestoreGState(context);
}

@end

NS_ASSUME_NONNULL_END
