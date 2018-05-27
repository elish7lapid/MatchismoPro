// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SquareCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SquareCreator

- (nullable UIBezierPath*)createInPathWithRect:(CGRect)rect {
  auto path = [UIBezierPath bezierPathWithRect:rect];
  return path;
}

@end

NS_ASSUME_NONNULL_END
