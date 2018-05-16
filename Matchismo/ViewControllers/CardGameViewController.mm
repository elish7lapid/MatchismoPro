// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)updateUI {
  for (UIButton *cardButton in self.cardButtons) {
    auto cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    auto card = [self.game cardAtIndex:cardButtonIndex];
    [self setCardButtonContents:cardButton forCard:card];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.currentGameScore];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  auto chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

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
- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card {
  return;
}

@end

NS_ASSUME_NONNULL_END
