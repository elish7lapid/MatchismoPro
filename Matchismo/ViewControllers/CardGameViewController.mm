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
@property (weak, readwrite, nonatomic) IBOutlet UIView *cardsSpace;
@end

@implementation CardGameViewController

static const auto kCardsSizeRatio = 0.6;
static const auto kCardsScaleFactor = 0.9;

- (void)viewDidLoad {
  [super viewDidLoad];
  _scaleMinimumNumCards = 4;
  _grid = [[Grid alloc] init];
  self.grid.cellAspectRatio = kCardsSizeRatio;
  self.grid.size = _cardsSpace.bounds.size;
  self.grid.minimumNumberOfCells = self.numCardsToMatch*self.scaleMinimumNumCards;
}

- (void)startNewGame { //todo all in subclass?
  [self initializeCardsArray];
  [self initializeGame];
  [self createCardsOnGrid];
}

- (void)createCardsOnGrid {
  auto count = 0;
  for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
    for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
      auto card = [self.game cardAtIndex:count];
      [self createCardViewInRect:[self.grid frameOfCellAtRow:i inColumn:j] forCard:card];
      count ++;
    }
  }
}

- (void)createCardViewInRect:(CGRect)rect forCard:(Card *)card {
  auto cardV = [self initializeBasicCardViewFromCard:card
                                              inRect:[self createScaledRectInFrame:rect]];
  [cardV setup];
  [self setTappingForCardView:cardV];
  [self.cards addObject:cardV];
  [self.cardsSpace addSubview:cardV];
}

// Abstract method.
- (nullable CardView *)initializeBasicCardViewFromCard:(Card *)card inRect:(CGRect)rect {
  return nil;
}

- (CGRect)createScaledRectInFrame:(CGRect)frame {
  auto x = frame.origin.x + (frame.size.width*(1 - kCardsScaleFactor)/2);
  auto y = frame.origin.y + (frame.size.height*(1 - kCardsScaleFactor)/2);
  return CGRectMake(x, y, frame.size.width*kCardsScaleFactor, frame.size.height*kCardsScaleFactor);
}

- (void)setTappingForCardView:(CardView *)cardV {
  auto tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)];
  [cardV addGestureRecognizer:tapgr];
}

- (void)tapCard:(UITapGestureRecognizer *)recognizer {
  auto pressed = (CardView *)recognizer.view;
  auto chosenButtonIndex = [self.cards indexOfObject:pressed];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (IBAction)touchRestartButton:(UIButton *)sender {
  [self startNewGame];
  [self updateUI];
}

- (void)updateUI {
  for (CardView *cardView in self.cards) {
    [self updateUIForCardView:cardView];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.currentGameScore];
}

- (void)updateUIForCardView:(CardView *)cardV {
  auto cardViewIndex = [self.cards indexOfObject:cardV];
  auto card = [self.game cardAtIndex:cardViewIndex];
  [self updateCardViewContents:cardV fromCard:card];
}

// An abstract method.
- (void)updateCardViewContents:(CardView *)cardV fromCard:(Card *)card {
  return;
}

@end

NS_ASSUME_NONNULL_END
