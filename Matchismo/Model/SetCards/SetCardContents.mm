// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardContents.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardContents

+ (NSInteger)numberOfTraits {
  return 4;
}

- (instancetype)initWithShapeSymbol:(NSString *)symbol numSymbols:(NSInteger)numShapes
                              color:(UIColor *)color
                           andPattern:(NSString *)pattern {
  
  if (self = [super init]) {
    _numSymbols = numShapes;
    _symbol = symbol;
    _color = color;
    _pattern = pattern;
  }
  return self;
}

- (BOOL)isMatchingNumSymbols:(SetCardContents *)otherContent {
  return self.numSymbols == otherContent.numSymbols;
}

- (BOOL)isMatchingSymbol:(SetCardContents *)otherContent {
  return [self.symbol isEqualToString:otherContent.symbol];
}

- (BOOL)isMatchingColor:(SetCardContents *)otherContent {
  return [self.color isEqual:otherContent.color];
}

- (BOOL)isMatchingPattern:(SetCardContents *)otherContent {
  return [self.pattern isEqualToString:otherContent.pattern];
}

@end

NS_ASSUME_NONNULL_END
