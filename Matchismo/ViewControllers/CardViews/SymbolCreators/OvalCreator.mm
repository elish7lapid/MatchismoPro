// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "OvalCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation OvalCreator

#pragma mark -
#pragma mark SymbolCreator

- (nullable UIBezierPath*)createInPathWithRect:(CGRect)rect {
  auto path = [UIBezierPath bezierPathWithOvalInRect:rect];
  return path;
}

#pragma mark -

@end

NS_ASSUME_NONNULL_END
