// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCard.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card()
/// Returns the cards chosen by the user, that were found matching
/// in the previous turn.
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;
@end

@implementation SetCard

+ (NSArray<UIColor *> *)validColors {
   return @[[UIColor greenColor], [UIColor purpleColor], [UIColor grayColor]];
}

+ (NSArray<NSString *> *)validShapes {
  return @[@"▲", @"●", @"■"];
}

- (instancetype)initWithShapeType:(NSString *)type andColor:(UIColor *)color {
  if (self = [super init]){
    _shape = [[NSAttributedString alloc] initWithString:type
                                             attributes:@{NSForegroundColorAttributeName : color}];
  }
  return self;
}

- (nullable NSString *)contents {
  return nil; // No string is represented on a \c SetCard card.
}

- (NSInteger)matchSingleOtherCard:(SetCard *)otherCard{
  NSInteger score = 0; // TODO:

  return score;
}

- (int)match:(NSArray<SetCard *> *)otherCards{
  int score = 0; //TODO

  return score;
}

@end

NS_ASSUME_NONNULL_END
