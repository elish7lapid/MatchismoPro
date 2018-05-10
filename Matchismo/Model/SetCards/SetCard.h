// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Card.h"

@class UIColor, SetCardContents;

NS_ASSUME_NONNULL_BEGIN

/// Object representing a card in a "Set" game.
@interface SetCard : Card

/// Returns the \c SetCardContents which is displayed on \c self.
@property (readonly, nonatomic) SetCardContents *shapeContents;

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c contents. Where \c contents is the \c SetCardContents that will
/// be presented on the card.
- (instancetype)initWithShapeSymbol:(NSString *)symbol numShapes:(NSInteger)numShapes
                              color:(UIColor *)color
                           andAlpha:(NSNumber *)alpha NS_DESIGNATED_INITIALIZER;

- (NSAttributedString *)contentsAsAtributtedString;

/// Returns the valid colors possible for a \c SetCard.
+ (NSArray<UIColor *> *)validColors;

+ (NSArray<NSNumber *> *)validAlphas;

/// Returns the valid shape types possible for a \c SetCard.
+ (NSArray<NSString *> *)validShapes;

/// Returns the maximal number of valid \c numShapes. The minimum number is 1.
+ (NSInteger)validMaximumNumShapes;

@end

NS_ASSUME_NONNULL_END
