// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardDeck.h"

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (UIColor *color in [SetCard validColors]) {
      [self addCardsWithColor:color];
    }
  }
  return self;
}

- (void)addCardsWithColor:(UIColor *)color {
  for (NSString *pattern in [SetCard validPatterns]) {
    [self addCardsWithColor:color andPattern: pattern];
  }
}

- (void)addCardsWithColor:(UIColor *)color andPattern:(NSString *)pattern {
  for (NSString *shapeType in [SetCard validSymbols]) {
    [self addCardWithColor:color pattern:pattern andShape:shapeType];
  }
}

- (void)addCardWithColor:(UIColor *)color pattern:(NSString *)pattern andShape:(NSString *)shape {
  for (NSInteger i = 1; i < ([SetCard validMaximumNumShapes] + 1); i++) {
    [self addCardWithColor:color pattern:pattern shape:shape andNumShapes:i];
  }
}

- (void)addCardWithColor:(UIColor *)color pattern:(NSString *)pattern shape:(NSString *)shape
            andNumShapes:(NSUInteger)numShapes {
  auto card = [[SetCard alloc] initWithShapeSymbol:shape numSymbols:numShapes color:color
                                           andPattern:pattern];
  [self addCard:card];
}

@end

NS_ASSUME_NONNULL_END
