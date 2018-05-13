// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card()
//The cards chosen by the user, that were found matching in the previous turn.
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;
@end

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *)validSuits {
  return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎" ];
}

+ (NSArray *)rankStrings {
  return @[@"?",@"A",@"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
  return [[self rankStrings] count] - 1;
}

- (void)setSuit:(NSString *)suit {
  if (![[PlayingCard validSuits] containsObject:suit]) {
    return;
  }
  _suit = suit;
}

- (NSString *)suit {
  return _suit ? _suit: @"?";
}

- (nullable NSString *)stringContents {
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setRank:(NSUInteger)rank {
  
  if (rank > [PlayingCard maxRank]) {
    return;
  }
  _rank = rank;
}

- (NSInteger)matchToSingleOtherCard:(PlayingCard *)otherCard {
  NSInteger score = 0;
  
  if (otherCard.rank == self.rank) {
    score = 4;
    
  } else if ([otherCard.suit isEqualToString:self.suit]){
    score = 1;
  }
  
  if (score > 0) {
    [self.lastMatchedCards addObject:otherCard];
  }
  return score;
}

@end

NS_ASSUME_NONNULL_END
