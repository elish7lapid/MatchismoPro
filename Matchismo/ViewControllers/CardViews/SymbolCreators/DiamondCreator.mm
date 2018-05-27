// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "DiamondCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DiamondCreator

- (nullable UIBezierPath*)createInPathWithRect:(CGRect)rect {
  auto path = [[UIBezierPath alloc] init];
  [path moveToPoint:CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y)];
  [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width, rect.origin.y +
                                   rect.size.height/2)];
  [path addLineToPoint:CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y +
                                   rect.size.height)];
  [path addLineToPoint:CGPointMake(rect.origin.x, rect.origin.y + rect.size.height/2)];
  [path closePath];
  return path;
}

@end

NS_ASSUME_NONNULL_END
