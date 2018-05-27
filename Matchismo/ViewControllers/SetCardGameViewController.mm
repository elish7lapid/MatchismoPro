// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()
// The card buttons displayed in the view.
@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray<SetCardView *> *cards;
@end

@implementation SetCardGameViewController

@dynamic cards;
@synthesize game = _game;

// Number of cards that are matched in one turn of the matching game.
static const NSUInteger kNumCardsToMatch = 3;
static const NSUInteger kScaleMinimumNumCards = 4;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self startNewGame];
}

- (void)startNewGame {
  self.grid.minimumNumberOfCells = kNumCardsToMatch*kScaleMinimumNumCards;
  _game = [[CardMatchingGame alloc] initWithCardCount:self.grid.rowCount*self.grid.columnCount
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = kNumCardsToMatch;
  [self createCardsOnGrid];
}

- (nullable CardView *)createCardViewFromCard:(SetCard *)card inRect:(CGRect)rect {
  auto cardV = [[SetCardView alloc] initWithFrame:rect];
  [self setCardViewProperties:cardV fromCard:card];
  return cardV;
}

- (void)setCardViewProperties:(SetCardView *)cardV fromCard:(SetCard *)card {
  //TODO
}

- (nullable Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
