// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardContents.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardContents

+ (NSInteger)numberOfTraits {
  return 4;
}

- (instancetype)initWithShapeSymbol:(NSString *)symbol numShapes:(NSInteger)numShapes
                              color:(UIColor *)color
                           andAlpha:(NSNumber *)alpha {
  
  if (self = [super init]) {
    _numShapes = numShapes;
    _shapeSymbol = symbol;
    _color = color;
    _alpha = alpha;
  }
  return self;
}

- (BOOL)isMatchingNumShapes:(SetCardContents *)otherContent {
  return self.numShapes == otherContent.numShapes;
}

- (BOOL)isMatchingShapeSymbol:(SetCardContents *)otherContent {
  return [self.shapeSymbol isEqualToString:otherContent.shapeSymbol];
}

- (BOOL)isMatchingColor:(SetCardContents *)otherContent {
  return [self.color isEqual:otherContent.color];
}

- (BOOL)isMatchingAlpha:(SetCardContents *)otherContent {
  return self.alpha == otherContent.alpha;
}

@end

NS_ASSUME_NONNULL_END
