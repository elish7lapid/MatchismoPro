// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CardView

typedef enum {
  kDiamond,
  kOval,
  kRectangle
}ContentsSymbol;

typedef enum {
  kSolid,
  kStriped,
  kUnfilled
}ContentsFillPattern;
  
@property (nonatomic) ContentsSymbol symbol;
@property (nonatomic) NSInteger numSymbols;
@property (nonatomic) UIColor *symbolColor;
@property (nonatomic) ContentsFillPattern fillPattern;

@end

NS_ASSUME_NONNULL_END
