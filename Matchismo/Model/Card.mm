// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card()
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;
@end

@implementation Card

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %p, suitAndRankcontents: %@, isChosen: %d, "
          "isMatched: %d>, lastMatchedCards: %@>", [self class], self, self.stringContents,
          self.isChosen, self.isMatched, self.lastMatchedCards];
}

- (NSInteger)matchToSingleOtherCard:(Card *)otherCard {
  if (![otherCard.stringContents isEqualToString:self.stringContents]){
    return 0;
  }
  [self.lastMatchedCards addObject:otherCard];
  return 1;
}

- (int)match:(NSArray<Card *> *)otherCards {
  int score = 0;
  self.lastMatchedCards = [NSMutableArray array];
  for (Card *card in otherCards){
    
    if (card == self) {
      continue;
    }
    score += [self matchToSingleOtherCard: card];
  }
  
  if (score > 0) {
    [self.lastMatchedCards addObject:self];
  }
  return score;
}

@end

NS_ASSUME_NONNULL_END
