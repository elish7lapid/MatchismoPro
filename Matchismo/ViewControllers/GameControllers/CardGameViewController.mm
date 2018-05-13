// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "HistoryCardGameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameSituationLabel;
@property (nonatomic) NSMutableArray<NSAttributedString *>* history;
@end

@implementation CardGameViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _history = [NSMutableArray array];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  if ([segue.identifier isEqualToString:@"Set History"] ||
      [segue.identifier isEqualToString:@"Matching History"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryCardGameViewController class]]) {
      HistoryCardGameViewController *historyView =
          (HistoryCardGameViewController *)segue.destinationViewController;
      for (NSAttributedString *event in self.history) {
        [historyView addHistory:event];
      }
    }
  }
}

- (NSAttributedString *)createGameSituationLabel {
  if (!self.game.turnEnded) {
    return [self createStringFromCardsArray: self.game.currentChosenCards];
  }
  auto cardsToDisplay = [[NSMutableAttributedString alloc] initWithString:@""];
  
  if ([self.game.lastMatchedCards count]) {
    cardsToDisplay = [self createStringFromCardsArray:self.game.lastMatchedCards];
    [cardsToDisplay appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:
                                            [NSString stringWithFormat:@" matched for %ld points!", self.game.lastTurnScore]]];
    return cardsToDisplay;
  }
  cardsToDisplay = [self createStringFromCardsArray:self.game.currentChosenCards];
  [cardsToDisplay appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:
                                          [NSString stringWithFormat:
                                           @" dont match!%ld point penalty!",
                                           self.game.lastTurnScore]]];
  return cardsToDisplay;
}

- (void)updateGameSituationLabel {
  auto gameSituationString = [self createGameSituationLabel];
  [self.history addObject:gameSituationString];
  self.gameSituationLabel.attributedText = gameSituationString;
}

- (void)updateUI {
  [self updateGameSituationLabel];
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
  self.history = [NSMutableArray array];
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
