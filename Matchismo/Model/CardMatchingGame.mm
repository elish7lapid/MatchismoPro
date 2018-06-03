// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardMatchingGame.h"

#import "Card.h"
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame()

/// The current (total) game score.
@property (readwrite, nonatomic) NSInteger currentGameScore;

/// The score of (only) the last turn.
@property (readwrite, nonatomic) NSInteger lastTurnScore;

/// The card being used in the current game.
@property (strong, nonatomic) NSMutableArray<Card *> *cards;

/// The list of cards that are currently chosen by the user.
@property (readwrite, nonatomic) NSMutableArray<Card *> *currentChosenCards;

/// The list of cards that were matched successfully by the user in the last choice.
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;

@property (readwrite, nonatomic) Card *lastChosenCard;

@property (nonatomic) Deck *deck;

@end

@implementation CardMatchingGame

// Penalty score a user payes to choose a card.
static const auto kCostToChoose = 1;

// A bonus score a user gets for successfully matching cards.
static const auto kMatchBonus = 4;

// Penalty score a user payes for an un-successful match of cards.
static const auto kMismatchPenalty = 2;

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %p, currentGameScore: %ld, lastTurnScore: %ld,"
          " numCardsToMatch: %ld,   currentChosenCards: %@, lastMatchedCards: %@, turnEnded: %d>",
          [self class], self, (long)self.currentGameScore, (long)self.lastTurnScore,
          (long)self.numCardsToMatch, self.currentChosenCards, self.lastMatchedCards,
          self.turnEnded];
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
  if (self = [super init]) {
    _numCardsToMatch = 2;
    _cards = [[NSMutableArray alloc] init];
    _deck = deck;
    for (int i = 0; i < count; i++) {
      auto gameCard = [self.deck drawRandomCard];
      if (!gameCard) {
        self = nil;
        break;
      }
      [self.cards addObject:gameCard];
    }
  }
  return self;
}

- (void)removeMatchedCardsFromGame {
  auto matched = [NSMutableArray array];
  for (Card* card in self.cards) {
    if (card.isMatched) {
      [matched addObject:card];
    }
  }
  [self.cards removeObjectsInArray:matched];
}

- (NSArray <Card *> *)dealMoreCards:(NSUInteger)numCards {
  auto newCards = [NSMutableArray array];
  for (NSInteger i=0; i < numCards; i ++) {
    auto card = [self.deck drawRandomCard];
    [newCards addObject:card];
    [self.cards addObject:card];
  }
  return newCards;
}

- (NSUInteger)numberOfCardsInGame {
  return [self.cards count];
}

- (BOOL)noMoreCardsToDeal {
  return [self.deck isDeckEmpty];
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index]: nil;
}

- (NSUInteger)indexOfCard:(Card *)card {
  return [self.cards indexOfObject:card];
}

- (void)updateBeginningOfMove {
  self.lastMatchedCards = [NSMutableArray array];
  self.lastTurnScore = 0;
  self.turnEnded = FALSE;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  if (self.turnEnded) {
    [self updateBeginningOfMove];
  }
  
  auto chosenCard = [self cardAtIndex:index];
  self.lastChosenCard = chosenCard;
  [self chooseCard:chosenCard];
  
  if (chosenCard.isChosen && !chosenCard.isMatched) {
    [self matchChosenCard: chosenCard];
  }
}

- (void)chooseCard:(Card *)card {
  if (card.isMatched) {
    return;
  }
  self.currentGameScore -= kCostToChoose;
  card.isChosen = !card.isChosen;
}

- (void)matchChosenCard:(Card *)chosenCard {
  [self updateCurrentChosenCards];
  [self updateLastMatchingMoveWithChosenCard:chosenCard];
  
  if ([self.currentChosenCards count] < self.numCardsToMatch) {
    return;
  }
  [self updateEndOfMove];
}

- (void)updateCurrentChosenCards {
  self.currentChosenCards = [[NSMutableArray alloc] init];
  for (Card *card in self.cards) {
    if ((card.isChosen) && (!card.isMatched)) {
      [self.currentChosenCards addObject:card];
    }
  }
}

- (void)updateLastMatchingMoveWithChosenCard:(Card *)chosenCard {
  int match = [self matchAllCurrentChosen];
  if (match > 0) {
    self.lastMatchedCards = chosenCard.lastMatchedCards;
    self.lastTurnScore = match;
  }
}

- (int)matchAllCurrentChosen {
  auto match = 0;
  for (Card *card in self.currentChosenCards) {
    match = [card match:self.currentChosenCards];
    if ([card.lastMatchedCards count] != self.numCardsToMatch) {
      return 0;
    }
  }
  return match;
}

- (void)updateEndOfMove {
  self.turnEnded = TRUE;
  
  if ([self.lastMatchedCards count]) {
    [self handleSuccessfullMatch];
  } else {
    [self handleMatchFail];
  }
}

- (void)handleSuccessfullMatch {
  self.lastTurnScore *= kMatchBonus;
  self.currentGameScore += self.lastTurnScore;
  for (Card *card in self.currentChosenCards) {
    card.isMatched = YES;
  }
}

- (void)handleMatchFail {
  self.lastTurnScore = -kMismatchPenalty;
  self.currentGameScore -= kMismatchPenalty;
  for (Card *card in self.currentChosenCards) {
    card.isChosen = NO;
  }
}

@end

NS_ASSUME_NONNULL_END
