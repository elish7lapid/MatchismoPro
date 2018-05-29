// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "Grid.h"
#import "CardView.h"

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
  _grid = [[Grid alloc] init];
  _grid.cellAspectRatio = kCardsSizeRatio;
  _grid.size = _cardsSpace.bounds.size;
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
  [self setCardViewContents:cardV forCard:card];
}

- (void)createCardsOnGrid {
  auto count = 0;
  for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
    for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
      Card *card = (Card *)[self.game cardAtIndex:count];
      auto frame = [self.grid frameOfCellAtRow:i inColumn:j];
      auto cardV = [self createCardViewFromCard:card inRect:[self createRectInFrame:frame]];
      [cardV setup];
      [self.cards addObject:cardV];
      [self.cardsSpace addSubview:cardV];
      count ++;
    }
  }
}

- (CGRect)createRectInFrame:(CGRect)frame {
  auto x = frame.origin.x + (frame.size.width*(1 - kCardsScaleFactor)/2);
  auto y = frame.origin.y + (frame.size.height*(1 - kCardsScaleFactor)/2);
  return CGRectMake(x, y, frame.size.width*kCardsScaleFactor, frame.size.height*kCardsScaleFactor);
}

- (nullable CardView *)createCardViewFromCard:(Card *)card inRect:(CGRect)rect {
  return nil;
}

//- (IBAction)touchCardButton:(UIButton *)sender {
//  auto chosenButtonIndex = [self.cards indexOfObject:sender];
//  [self.game chooseCardAtIndex:chosenButtonIndex];
//  [self updateUI];
//}

- (IBAction)touchRestartButton:(UIButton *)sender {
  [self startNewGame];
  [self updateUI];
}

// An abstract method.
- (nullable Deck *)createDeck {
  return nil;
}

// An abstract method.
- (nullable UIImage *)backgroundImageForCard:(Card *)card {
  return nil;
}

// An abstract method.
- (void)startNewGame {
  return;
}

// An abstract method.
- (nullable NSMutableAttributedString *)createStringFromCardsArray:
    (NSMutableArray<Card *> *) cardsArray {
  return nil;
}

// An abstract method.
- (void)setCardViewContents:(CardView *)cardView forCard:(Card *)card {
  return;
}

@end

NS_ASSUME_NONNULL_END
