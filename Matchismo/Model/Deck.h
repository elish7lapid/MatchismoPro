// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Card;

/// Object representing a cards deck.
@interface Deck : NSObject

/// if \c atTop is YES the method will add \c card to the top of the deck, else it will add
/// \c card to the bottom.
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

/// Adding \c card to the bottom of the Deck.
- (void)addCard:(Card *)card;

/// Returns a random card chosen from the deck. Returns \c nil if the deck is out of cards.
- (nullable Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
