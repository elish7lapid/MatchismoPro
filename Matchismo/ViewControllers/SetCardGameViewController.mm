// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "CardMatchingGame.h"
#import "Grid.h"
#import "SetCard.h"
#import "SetCardContents.h"
#import "SetCardDeck.h"
#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()
// The card buttons displayed in the view.
@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray<SetCardView *> *cards;
@end

@implementation SetCardGameViewController

@synthesize cards = _cards;
@synthesize game = _game;
@synthesize numCardsToMatch = _numCardsToMatch;

- (void)viewDidLoad {
  _numCardsToMatch = 3;
  [super viewDidLoad];
  [self startNewGame];
}

- (void)initializeGame {
  _game = [[CardMatchingGame alloc] initWithCardCount:self.grid.rowCount*self.grid.columnCount
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = self.numCardsToMatch;
}

- (void)initializeCardsArray {
  if (!_cards) {
    _cards = [NSMutableArray array];
  }
  else {
    [self.cards makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.cards = [NSMutableArray array];
  }
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
}

- (nullable Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
