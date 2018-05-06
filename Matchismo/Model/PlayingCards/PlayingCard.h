// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Card.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object representing a regular playing card.
@interface PlayingCard : Card

/// Returns the valid suits possible for a \c PlayingCard.
+ (NSArray *)validSuits;

/// Returns the maximum rank allowed for a \c PlayingCard.
+ (NSUInteger)maxRank;

/// Returns the suit of \c self.
@property (nonatomic) NSString *suit;

/// Returns the rank of \c self.
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END
