// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "CardMatchingGame.h"
#import "SetCard.h"
#import "SetCardContents.h"
#import "SetCardDeck.h"
#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardGameViewController

@synthesize game = _game;
@synthesize scaleMinimumNumCards = _scaleMinimumNumCards;
@synthesize numCardsToMatch = _numCardsToMatch;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
  _numCardsToMatch = 3;
  _scaleMinimumNumCards = 4;
  [super viewDidLoad];
  [self startNewGame];
}

#pragma mark -
#pragma mark CardGameViewController

- (nullable Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (void)updateUI {
  [super updateUI];
  if ([self.game.lastMatchedCards count] == self.numCardsToMatch) {
    [self removeCardsFromViewWithFadeOut: [self getCardViewsFromCardsArray:
                                           self.game.lastMatchedCards]];
    [self.game removeMatchedCardsFromGame];
    return;
  }
}

- (void)initializeGame {
  _game = [[CardMatchingGame alloc] initWithCardCount:self.numCardsToMatch*self.scaleMinimumNumCards
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = self.numCardsToMatch;
}

- (nullable CardView *)initializeBasicCardViewFromCard:(SetCard *)card inRect:(CGRect)rect {
  auto cardV = [[SetCardView alloc] initWithFrame:rect];
  [self updateCardViewContents:cardV fromCard:card];
  return cardV;
}

- (void)updateCardViewContents:(SetCardView *)cardV fromCard:(SetCard *)card; {
  cardV.symbol = [SetCardView stringToSymbol:card.setContents.symbol];
  cardV.numSymbols = card.setContents.numSymbols;
  cardV.symbolColor = card.setContents.color;
  cardV.fillPattern = [SetCardView stringToPattern:card.setContents.pattern];
  cardV.isChosen = card.isChosen;
}

#pragma mark -

- (NSArray<CardView *> *)getCardViewsFromCardsArray:(NSArray<Card *> *)cardsArr {
  auto ret = [NSMutableArray array];
  for (Card *card in cardsArr) {
    auto cardV = [self.cardViews objectAtIndex:[self.game indexOfCard:card]];
    [ret  addObject:cardV];
  }
  return ret;
}

@end

NS_ASSUME_NONNULL_END
