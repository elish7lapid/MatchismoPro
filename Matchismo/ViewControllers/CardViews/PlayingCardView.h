// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// Represents a UIView of a regular playing card.
@interface PlayingCardView : CardView

/// Returns the rank of \c self.
@property (nonatomic) NSUInteger rank;

/// Returns the suit of \c self.
@property (strong, nonatomic) NSString *suit;

/// If \c YES than the card is faced up. else, it is faced down.
@property (nonatomic) BOOL faceUp;

@end

NS_ASSUME_NONNULL_END
