// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardDeck.h"

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardDeck

- (instancetype)init {
  if (self = [super init]) {
    for (UIColor *color in [SetCard validColors]) {
      for (NSString *shapeType in [SetCard validShapes]) {
        auto *card = [[SetCard alloc] initWithShapeType:shapeType andColor:color];
        [self addCard:card];
      }
    }
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
