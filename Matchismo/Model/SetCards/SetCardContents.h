// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>

@class UIColor;

NS_ASSUME_NONNULL_BEGIN

/// Object representing the contents displayed on a \c SetCard.
@interface SetCardContents : NSObject

/// The number of shapes displayed on the \c SetCard. Valid value is between 1 and \c
/// [validMaximumNumShapes].
@property (readonly, nonatomic) NSInteger numShapes;

/// The symbol of the shape displayed on the \c SetCard. Only \c [validShapes] allowed.
@property (readonly, nonatomic) NSString *shapeSymbol;

/// The color and shading of the shape displayed on the \c SetCard. Only \c [validColors] allowed.
@property (readonly, nonatomic) UIColor *color;

@property (readonly, nonatomic) NSNumber *alpha;

+ (NSInteger)numberOfTraits;

- (instancetype)init NS_UNAVAILABLE;

/// Initializes with the given \c symbol, \c numShapes, \c colorWithShading.
/// Where \c symbol is the symbol of the shape displayed on the \c SetCard.
/// Only \c [validShapes] allowed. \c numShapes is the number of shapes displayed on the \c SetCard,
/// where the Valid value is between 1 and \c [validMaximumNumShapes], and \c colorWithShading is
/// the color and shading of the shape displayed on the \c SetCard. Only \c [validColors] allowed.
- (instancetype)initWithShapeSymbol:(NSString *)symbol numShapes:(NSInteger)numShapes
                              color:(UIColor *)color
                           andAlpha:(NSNumber *)alpha NS_DESIGNATED_INITIALIZER;

- (BOOL)isMatchingNumShapes:(SetCardContents *)otherContent;

- (BOOL)isMatchingShapeSymbol:(SetCardContents *)otherContent;

- (BOOL)isMatchingColor:(SetCardContents *)otherContent;

- (BOOL)isMatchingAlpha:(SetCardContents *)otherContent;

@end

NS_ASSUME_NONNULL_END
