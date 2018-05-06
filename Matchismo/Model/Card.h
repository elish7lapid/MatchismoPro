// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Object representing a card.
@interface Card : NSObject

/// Check if \c self matches cards in \c otherCards and return a score given for succesfully
/// (or un-successfully) matching cards.
- (int)match:(NSArray *)otherCards;

/// The string written on the card. If no string should be presented on the card, it is \c nil.
@property (nullable, strong, nonatomic) NSString *contents;

/// If \c YES then the card is currently chosen by the user, else it is not chosen.
@property (nonatomic) BOOL isChosen;

/// If \c YES the card was already found matching to some other card, else the card is not matched
/// to any other card yet.
@property (nonatomic) BOOL isMatched;

/// Returns the cards chosen by the user, that were found matching
/// in the previous turn.
@property (readonly, nonatomic) NSMutableArray<Card *> *lastMatchedCards;

@end

NS_ASSUME_NONNULL_END
