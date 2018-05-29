// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@class UIColor, SetCardContents;

/// Object representing a card in a "Set" game.
@interface SetCard : Card

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c symbol, \c numSymbols, \c color, \c alpha. Where all of these
/// parameters represent the contents of the \c SetCard: \c symbol is the symbol on the card,
/// \c numSymbols is the number of symbols on the card, \c color is the symbol's color and
/// \c alpha is the transparency of the color.
- (instancetype)initWithShapeSymbol:(NSString *)symbol numSymbols:(NSInteger)numSymbols
                              color:(UIColor *)color
                           andPattern:(NSString *)pattern NS_DESIGNATED_INITIALIZER;

/// Returns the valid colors possible for a \c SetCard.
+ (NSArray<UIColor *> *)validColors;

/// Returns the valid alpha values possible for a \c SetCard.
+ (NSArray<NSNumber *> *)validPatterns;

/// Returns the valid symbols possible for a \c SetCard.
+ (NSArray<NSString *> *)validSymbols;

/// Returns the maximal number of valid symbols displayed on a card. The minimum number is 1.
+ (NSInteger)validMaximumNumShapes;

/// The \c SetCardContents containing all of the contsnts properties displayed on \c self.
@property (readonly, nonatomic) SetCardContents *setContents;

@end

NS_ASSUME_NONNULL_END
