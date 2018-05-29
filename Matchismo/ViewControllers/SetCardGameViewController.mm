// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "Grid.h"
#import "SetCardContents.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()
// The card buttons displayed in the view.
@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray<SetCardView *> *cards;
@end

@implementation SetCardGameViewController

@synthesize cards = _cards;
@synthesize game = _game;

// Number of cards that are matched in one turn of the matching game.
static const NSUInteger kNumCardsToMatch = 3;
static const NSUInteger kScaleMinimumNumCards = 4;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self startNewGame];
}

- (void)updateCardViews {
  for (SetCardView *cardView in self.cards) {
    [self updateUIForCardView:cardView];
  }
}

- (void)updateUIForCardView:(SetCardView *)cardV {
  auto cardViewIndex = [self.cards indexOfObject:cardV];
  auto card = [self.game cardAtIndex:cardViewIndex];
  [self updateCardViewContents:cardV fromCard:card];
}

- (void)startNewGame {
  _cards = [NSMutableArray array];
  self.grid.minimumNumberOfCells = kNumCardsToMatch*kScaleMinimumNumCards;
  _game = [[CardMatchingGame alloc] initWithCardCount:self.grid.rowCount*self.grid.columnCount
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = kNumCardsToMatch;
  [self createCardsOnGrid];
}

- (nullable CardView *)createCardViewFromCard:(SetCard *)card inRect:(CGRect)rect {
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
