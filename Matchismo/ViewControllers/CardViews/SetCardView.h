// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CardView

typedef enum {
  kTriangle,
  kSquare,
  kSquiggle
}ContentsSymbol;

typedef enum {
  kSolid,
  kStriped,
  kUnfilled
}ContentsFillPattern;
  
@property ContentsSymbol symbol;
@property NSInteger numSymbols;
@property UIColor *symbolColor;
@property ContentsFillPattern fillPattern;

@end

NS_ASSUME_NONNULL_END
