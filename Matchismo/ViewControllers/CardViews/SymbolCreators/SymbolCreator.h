// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Creates a symbol to be drawed on a UIBezierPath.
@interface SymbolCreator : NSObject

/// Creates a symbol inside the given \c rect on a new bezier path (returned).
- (nullable UIBezierPath*)createInPathWithRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
