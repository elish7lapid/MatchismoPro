// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card()
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;
@end

@implementation Card

- (NSString *)description
{
  return [NSString stringWithFormat:@"<%@: %p, suitAndRankcontents: %@, isChosen: %d, "
          "isMatched: %d>, lastMatchedCards: %@>", [self class], self, self.contents,
          self.isChosen, self.isMatched, self.lastMatchedCards];
}

- (int)matchToSingleOtherCard:(Card *)otherCard{
  if (![otherCard.contents isEqualToString:self.contents]){
    return 0;
  }
  [self.lastMatchedCards addObject:otherCard];
  return 1;
}

- (int)match:(NSArray *)otherCards{
  int score = 0;
  for (Card *card in otherCards) {
    if (card == self) {
      continue;
    }
    score = [self matchToSingleOtherCard:card];
  }
  
  if (score > 0) {
    [self.lastMatchedCards addObject:self];
  }
  return score;
}

@end

NS_ASSUME_NONNULL_END
