// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

/// Represents a UIView of Set card.
@interface SetCardView : CardView

/// Represents the possible symbols drawn on a set card.
typedef NS_ENUM(NSInteger, ContentsSymbol) {
  kDiamond,
  kOval,
  kRectangle
};

/// Represents the possible filling patterns of a shape on a set card.
typedef NS_ENUM(NSInteger, ContentsFillPattern) {
  kSolid,
  kStriped,
  kUnfilled
};

/// The symbol drawn on the set card.
@property (nonatomic) ContentsSymbol symbol;

/// The number of symbols drawn on the set card.
@property (nonatomic) NSInteger numSymbols;

/// The color of the symbols drawn on the set card.
@property (nonatomic) UIColor *symbolColor;

/// The filling pattern of the symbols drawn on the set card.
@property (nonatomic) ContentsFillPattern fillPattern;

/// If \c YES than the card is currently chosen by the user. Else, it is not.
@property (nonatomic) BOOL isChosen;

/// Convert a string representing a symbol to a \c ContentsSymbol type. Example: \c @"diamond" will
/// be converted to \c kDiamond.
+ (ContentsSymbol)stringToSymbol:(NSString *)symbString;

/// Convert a string representing a filling pattern to a \c ContentsFillPattern type.
/// Example: \c @"solid" will be converted to \c kSolid.
+ (ContentsFillPattern)stringToPattern:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END
