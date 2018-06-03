// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardView.h"

#import "DiamondCreator.h"
#import "OvalCreator.h"
#import "SquareCreator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()
@property (nonatomic) CGFloat symbolScaleFactor;
@end

@implementation SetCardView

@synthesize symbolScaleFactor = _symbolScaleFactor;

static const auto kDefaultSymbolScaleFactor = 0.50;
static const auto kMarginsScale = 0.10;
static const NSUInteger kStripesMarginsScale = 4;

+ (ContentsSymbol)stringToSymbol:(NSString *)symbString {
  if ([symbString isEqualToString:@"♦︎"]) {
    return kDiamond;
  }
  if ([symbString isEqualToString:@"●"]) {
    return kOval;
  }
  if ([symbString isEqualToString:@"■"]) {
    return kRectangle;
  }
  return kDiamond;
}

+ (ContentsFillPattern)stringToPattern:(NSString *)pattern {
  if ([pattern isEqualToString:@"solid"]) {
    return kSolid;
  }
  if ([pattern isEqualToString:@"None"]) {
    return kUnfilled;
  }
  return kStriped;
}

+ (SymbolCreator *)drawersFactory:(ContentsSymbol)symbol {
  switch (symbol) {
    case kDiamond:
      return [[DiamondCreator alloc] init];
    case kOval:
      return [[OvalCreator alloc] init];
    case kRectangle:
      return [[SquareCreator alloc] init];
    default:
      break;
  }
  return nil;
}

- (void)drawContents {
  if (self.isChosen) {
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 5.0f;
  }
  else {
    self.layer.borderColor = nil;
    self.layer.borderWidth = 0.0f;
  }
  auto drawer = [SetCardView drawersFactory:self.symbol];
  [self drawSymbolsWithSymbolsCreator:drawer];
}

- (void)drawSymbolsWithSymbolsCreator:(SymbolCreator *)creator {
  auto mainPath = [[UIBezierPath alloc] init];
  for (NSValue *symbRect in [self rectsForSymbols]){
    auto contentsPath = [creator createInPathWithRect:[symbRect CGRectValue]];
    [mainPath appendPath:contentsPath];
  }
  [mainPath addClip];
  [self paintPath:mainPath];
}

- (NSMutableArray<NSValue *> *)rectsForSymbols {
  auto symbolWidth = self.bounds.size.width*kDefaultSymbolScaleFactor;
  auto symbolHeight = symbolWidth/2;
  auto x = self.bounds.size.width*(1-kDefaultSymbolScaleFactor)/2;
  auto y = (self.bounds.size.height/2) - (symbolHeight*self.numSymbols/2) - ([self contentsMargins]*(self.numSymbols - 1)/2);
  auto squaresArr = [NSMutableArray array];
  [squaresArr addObject:[NSValue valueWithCGRect: CGRectMake(x, y, symbolWidth, symbolHeight)]];
  for (NSInteger i = 1; i < self.numSymbols; i ++) {
    y += symbolHeight + [self contentsMargins];
    [squaresArr addObject:[NSValue valueWithCGRect: CGRectMake(x, y, symbolWidth, symbolHeight)]];
  }
  return squaresArr;
}

- (void)paintPath:(UIBezierPath *)path {
  [self.symbolColor setFill];
  [self fillPathWithPattern:path];
  [self.symbolColor setStroke];
  [path stroke];
}

- (void)fillPathWithPattern:(UIBezierPath *)path {
  switch (self.fillPattern) {
    case kSolid:
      [path fill];
      break;
    case kStriped:
      [self createStrippedFillingInPath:path];
      break;
    case kUnfilled:
      break;
    default:
      break;
  }
}

- (void)createStrippedFillingInPath:(UIBezierPath *)path {
  for (NSInteger i=0; i < self.bounds.size.width; i += kStripesMarginsScale) {
    [path moveToPoint:CGPointMake(i, 0)];
    [path addLineToPoint:CGPointMake(i, self.bounds.size.height)];
  }
}

- (CGFloat)contentsMargins {
  return kMarginsScale*self.bounds.size.height*kDefaultSymbolScaleFactor;
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

- (void)setIsChosen:(BOOL)isChosen {
  if (_isChosen == isChosen) {
    return;
  }
  _isChosen = isChosen;
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
