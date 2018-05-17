// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SymbolCreator : NSObject

- (void)createInContext:(CGContextRef)context;
- (CGFloat)scaleForWidth:(CGFloat)width andHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
