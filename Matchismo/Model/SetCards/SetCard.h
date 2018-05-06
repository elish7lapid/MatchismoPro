// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Card.h"

@class UIColor, SetCardShape;

NS_ASSUME_NONNULL_BEGIN

/// Object representing a card in a "Set" game.
@interface SetCard : Card

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c type, \c color. Where \c type is the type of the shape that will
/// be presented on the card and \c color is the shape's color.
- (instancetype)initWithShapeType:(NSString *)type
                         andColor:(UIColor *)color NS_DESIGNATED_INITIALIZER;

/// Returns the valid colors possible for a \c SetCard.
+ (NSArray<UIColor *> *)validColors;

/// Returns the valid shape types possible for a \c SetCard.
+ (NSArray<NSString *> *)validShapes;

/// Returns the shape which is displayed on \c self.
@property (readonly, nonatomic) NSAttributedString *shape;

@end

NS_ASSUME_NONNULL_END
