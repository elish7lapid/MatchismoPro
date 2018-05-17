// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardView.h"

#import "SquiggleSymbolCreator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()
@property (nonatomic) CGFloat symbolScaleFactor;
@end

@implementation SetCardView

@synthesize symbolScaleFactor = _symbolScaleFactor;

static const auto kDefaultSymbolScaleFactor = 0.70;

+ (SymbolCreator *)drawersFactory:(ContentsSymbol)symbol {
  switch (symbol) {
    case kTriangle:
      break;
    case kSquare:
      break;
    case kSquiggle:
      return [[SquiggleSymbolCreator alloc]init];
    default:
      break;
  }
  return nil;
}

- (void)drawContents {
  auto drawer = [SetCardView drawersFactory:self.symbol];
  CGContextRef context = UIGraphicsGetCurrentContext();
  auto scale = [drawer scaleForWidth:[self desiredWidth] andHeight:[self desiredHeight]];
  CGContextScaleCTM(context, scale, scale);
  CGContextTranslateCTM(context, [self xCoordForShapeWithWidth:107.8],
                        [self initialYCoordForShapeWithHeight:[self desiredHeight]]);
  [drawer createInContext:context];
  CGContextTranslateCTM(context, 10, 10);
  [drawer createInContext:context];
  // draw the squiggle
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context, 2.0 );
  CGContextStrokePath(context);
  
}

- (CGFloat)xCoordForShapeWithWidth:(CGFloat)width { // todo doesnt scale right
  return (self.bounds.size.width / 2) - (width/2);
}

- (CGFloat)initialYCoordForShapeWithHeight:(CGFloat)height { //todo doesnt scale right
  return (self.bounds.size.height / 2) - (((height + 1 - self.symbolScaleFactor)*self.numSymbols)/2);
}

- (CGFloat)desiredWidth {
  return self.bounds.size.width * self.symbolScaleFactor;
}

- (CGFloat)desiredHeight {
  return (self.bounds.size.height / self.numSymbols) * self.symbolScaleFactor;
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
