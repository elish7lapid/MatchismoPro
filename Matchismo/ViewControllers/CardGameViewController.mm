// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "CardView.h"
#import "Grid.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (readwrite, nonatomic) IBOutlet UIView *cardsSpace;
@property (weak, nonatomic) IBOutlet UILabel *outOfCardsLabel;
@end

@implementation CardGameViewController

static const auto kCardsSizeRatio = 0.6;
static const auto kCardsScaleFactor = 0.9;

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initGrid];
}

- (void)initGrid {
  _grid = [[Grid alloc] init];
  self.grid.cellAspectRatio = kCardsSizeRatio;
  self.grid.size = _cardsSpace.bounds.size;
  self.grid.minimumNumberOfCells = self.numCardsToMatch*self.scaleMinimumNumCards;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self relocateCardsOnGrid];
}

- (IBAction)touchRestartButton:(UIButton *)sender {
  [self startNewGame];
  [self updateUI];
}

- (void)updateUI {
  for (CardView *cardView in self.cardViews) {
    [self updateUIForCardView:cardView];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.currentGameScore];
}

- (void)updateUIForCardView:(CardView *)cardV {
  auto cardViewIndex = [self.cardViews indexOfObject:cardV];
  auto card = [self.game cardAtIndex:cardViewIndex];
  [self updateCardViewContents:cardV fromCard:card];
}

// An abstract method.
- (void)updateCardViewContents:(CardView *)cardV fromCard:(Card *)card {
  return;
}

- (void)startNewGame {
  self.outOfCardsLabel.text = @"";
  self.grid.minimumNumberOfCells = self.numCardsToMatch * self.scaleMinimumNumCards;
  [self initializeCardsArray];
  [self initializeGame];
  [self createCardsOnGrid];
}

- (void)initializeCardsArray {
  if (!_cardViews) {
    _cardViews = [NSMutableArray array];
  }
  else {
    [self.cardViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _cardViews = [NSMutableArray array];
  }
}

// Abstract method.
- (void)initializeGame {
  return;
}

- (void)createCardsOnGrid {
  for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
    for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
      [self createCardViewInRow:i col:j];
    }
  }
}

- (void)createCardViewInRow:(NSUInteger)row col:(NSUInteger)col {
  auto flatIdx = (self.grid.columnCount*row) + col;
  if ((flatIdx + 1) > (self.grid.minimumNumberOfCells)) {
    return;
  }
  auto card = [self.game cardAtIndex:flatIdx];
  auto cardV = [self createCardViewInRect:[self.grid frameOfCellAtRow:row inColumn:col]
                                  forCard:card];
  [self addCardViewToGame:cardV];
}

- (IBAction)tapDealButton:(id)sender {
  if ([self.game noMoreCardsToDeal]) {
    self.outOfCardsLabel.text = @"Out of cards!";
    return;
  }
  auto newCards = [self.game dealMoreCards:self.numCardsToMatch];
  for (Card* card in newCards) {
    auto cardV = [self createCardViewInRect:CGRectMake(0, 0, 10, 20) forCard:card];
    [self addCardViewToGame:cardV];
  }
  [self relocateCardsOnGrid];
}

- (CardView *)createCardViewInRect:(CGRect)rect forCard:(Card *)card {
  auto cardV = [self initializeBasicCardViewFromCard:card
                                              inRect:[self createScaledRectInFrame:rect]];
  [cardV setup];
  return cardV;
}

// Abstract method.
- (nullable CardView *)initializeBasicCardViewFromCard:(Card *)card inRect:(CGRect)rect {
  return nil;
}

- (void)addCardViewToGame:(CardView *)cardV {
  [self setTappingForCardView:cardV];
  [self.cardViews addObject:cardV];
  [self.cardsSpace addSubview:cardV];
}

- (void)setTappingForCardView:(CardView *)cardV {
  auto tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)];
  [cardV addGestureRecognizer:tapgr];
}

- (void)tapCard:(UITapGestureRecognizer *)recognizer {
  auto pressed = (CardView *)recognizer.view;
  auto chosenButtonIndex = [self.cardViews indexOfObject:pressed];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (void)relocateCardsOnGrid {
  [self readjustGrid];
  [self animateRelocateCardsOnGrid];
}

- (void)readjustGrid {
  self.grid.minimumNumberOfCells = [self.cardViews count];
  self.grid.size = _cardsSpace.bounds.size;
}

- (void)animateRelocateCardsOnGrid {
  for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
    for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
      [self relocateCardViewOnRow:i col:j];
    }
  }
}

- (void)relocateCardViewOnRow:(NSUInteger)row col:(NSUInteger)col {
  auto flatIdx = (self.grid.columnCount * row) + col;
  if (flatIdx >= [self.cardViews count]) {
    return;
  }
  auto cardV = [self.cardViews objectAtIndex:flatIdx];
  auto frame = [self.grid frameOfCellAtRow:row inColumn:col];
  if (CGPointEqualToPoint(cardV.center, [self.grid centerOfCellAtRow:row inColumn:col])) {
    return;
  }
  [self animateReadjustFrame:frame forCardView:cardV];
}

- (void)animateReadjustFrame:(CGRect)frame forCardView:(CardView *)cardV {
  [UIView animateWithDuration:0.8 animations:^{
    [cardV setFrame:[self createScaledRectInFrame:frame]];
  }];
}

- (CGRect)createScaledRectInFrame:(CGRect)frame {
  auto x = frame.origin.x + (frame.size.width*(1 - kCardsScaleFactor)/2);
  auto y = frame.origin.y + (frame.size.height*(1 - kCardsScaleFactor)/2);
  return CGRectMake(x, y, frame.size.width*kCardsScaleFactor, frame.size.height*kCardsScaleFactor);
}

- (void)removeCardsFromViewWithFadeOut:(NSArray<CardView *> *)cardsToRemove {
  [UIView animateWithDuration:0.8 animations:^{[self fadeOutCardViews:cardsToRemove];}
                   completion:^(BOOL finished){
                     [self removeCardsFromView:cardsToRemove];
                     [self relocateCardsOnGrid];
                   }];
}

- (void)fadeOutCardViews:(NSArray<CardView *> *)cardViews {
  for (CardView *cardV in cardViews) {
    cardV.alpha = 0.0;
  }
}

- (void)removeCardsFromView:(NSArray<CardView *> *)cardsToRemove {
  [self.cardViews removeObjectsInArray:cardsToRemove];
  [cardsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end

NS_ASSUME_NONNULL_END
