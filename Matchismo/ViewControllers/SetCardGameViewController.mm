// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "SetCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardGameViewController

- (nullable Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
