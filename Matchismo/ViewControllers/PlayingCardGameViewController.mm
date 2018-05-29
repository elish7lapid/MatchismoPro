// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "Grid.h"
#import "PlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController()
// The card buttons displayed in the view.
@property (strong, readwrite, nonatomic) IBOutletCollection(UIView)
                                         NSMutableArray<PlayingCardView *> *cards;
@end

@implementation PlayingCardGameViewController

@synthesize game = _game;
@synthesize cards = _cards;

// Number of cards that are matched in one turn of the matching game.
static const NSUInteger kNumCardsToMatch = 2;
static const NSUInteger kScaleMinimumNumCards = 4;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self startNewGame];
}

- (void)startNewGame {
  _cards = [NSMutableArray array];
  self.grid.minimumNumberOfCells = kNumCardsToMatch*kScaleMinimumNumCards;
  _game = [[CardMatchingGame alloc] initWithCardCount:self.grid.rowCount*self.grid.columnCount
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = kNumCardsToMatch;
  [self createCardsOnGrid];
}

- (nullable CardView *)createCardViewFromCard:(PlayingCard *)card inRect:(CGRect)rect {
  auto cardV = [[PlayingCardView alloc] initWithFrame:rect];
  [self setCardViewContents:cardV forCard:card];
  return cardV;
}

- (void)setCardViewContents:(PlayingCardView *)cardV forCard:(PlayingCard *)card {
  cardV.rank = card.rank;
  cardV.suit = card.suit;
  cardV.faceUp = card.isChosen;
}

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
