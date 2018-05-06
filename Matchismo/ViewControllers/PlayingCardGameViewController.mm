// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardGameViewController.h"

#import "PlayingCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
