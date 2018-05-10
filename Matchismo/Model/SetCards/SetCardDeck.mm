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
  for (NSNumber *alpha in [SetCard validAlphas]) {
    [self addCardsWithColor:color andAlpha: alpha];
  }
}

- (void)addCardsWithColor:(UIColor *)color andAlpha:(NSNumber *)alpha {
  for (NSString *shapeType in [SetCard validShapes]) {
    [self addCardWithColor:color alpha:alpha andShape:shapeType];
  }
}

- (void)addCardWithColor:(UIColor *)color alpha:(NSNumber *)alpha andShape:(NSString *)shape {
  for (NSInteger i = 1; i < ([SetCard validMaximumNumShapes] + 1); i++) {
    [self addCardWithColor:color alpha:alpha shape:shape andNumShapes:i];
  }
}

- (void)addCardWithColor:(UIColor *)color alpha:(NSNumber *)alpha shape:(NSString *)shape
            andNumShapes:(NSUInteger)numShapes {
  auto *card = [[SetCard alloc] initWithShapeSymbol:shape numShapes:numShapes color:color andAlpha:alpha];
  [self addCard:card];
}

@end

NS_ASSUME_NONNULL_END
