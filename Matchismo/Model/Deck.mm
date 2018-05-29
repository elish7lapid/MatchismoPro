// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Deck.h"

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck()
// The cards assembling the deck.
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards {
  if(!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  }else{
    [self.cards addObject:card];
  }
}
- (void)addCard:(Card *)card{
  [self addCard:card atTop:NO];
}

- (nullable Card *)drawRandomCard {
  if (![self.cards count]) {
    return nil;
  }
  Card *randomCard = nil;
  unsigned index = arc4random() % [self.cards count];
  randomCard = self.cards[index];
  [self.cards removeObjectAtIndex:index];
  return randomCard;
}

- (BOOL)isDeckEmpty {
  return ![self.cards count];
}

@end

NS_ASSUME_NONNULL_END
