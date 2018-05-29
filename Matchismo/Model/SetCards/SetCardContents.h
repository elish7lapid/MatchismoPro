// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>

@class UIColor;

NS_ASSUME_NONNULL_BEGIN

/// Object representing the contents displayed on a \c SetCard.
@interface SetCardContents : NSObject

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c symbol, \c numSymbols, \c color, \c alpha. Where all of these
/// parameters represent the contents of a \c SetCard: \c symbol is the symbol on a card,
/// \c numSymbols is the number of symbols on a card, \c color is the symbol's color and
/// \c alpha is the transparency of the color.
- (instancetype)initWithShapeSymbol:(NSString *)symbol numSymbols:(NSInteger)numSymbols
                              color:(UIColor *)color
                           andPattern:(NSString *)pattern NS_DESIGNATED_INITIALIZER;

/// If YES, then \c numSymbols equals to \c otherContent.numSymbols, else it is not equal.
- (BOOL)isMatchingNumSymbols:(SetCardContents *)otherContent;

/// If YES, then \c symbol equals to \c otherContent.symbol, else it is not equal.
- (BOOL)isMatchingSymbol:(SetCardContents *)otherContent;

/// If YES, then \c color equals to \c otherContent.color, else it is not equal.
- (BOOL)isMatchingColor:(SetCardContents *)otherContent;

/// If YES, then \c alpha equals to \c otherContent.alpha, else it is not equal.
- (BOOL)isMatchingPattern:(SetCardContents *)otherContent;

/// Returns the number of traits a \c SetCardContents have. E.g, if the contents of a card only have
/// a symbol and a color, then it has 2 traits.
+ (NSInteger)numberOfTraits;

/// The number of symbols displayed on the \c SetCard.
@property (readonly, nonatomic) NSInteger numSymbols;

/// The symbol displayed on the \c SetCard.
@property (readonly, nonatomic) NSString *symbol;

/// The color symbol displayed on the \c SetCard.
@property (readonly, nonatomic) UIColor *color;

/// The trancparicy of \c color.
@property (readonly, nonatomic) NSString *pattern;


@end

NS_ASSUME_NONNULL_END
