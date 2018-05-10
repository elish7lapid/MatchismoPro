// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameSituationLabel;
@end

@implementation CardGameViewController

- (nullable Deck *)createDeck {
  return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return nil;
}

- (void)startNewGame{
  return; //does nothing. abstract.
}

- (NSString *)createStringFromCardsArray:(NSMutableArray<Card *> *) cardsArray {
  auto concatenatedArrayString = @"";
  for (Card *cardFromArray in cardsArray) {
    if (!cardFromArray.stringContents) {
      continue;
    }
    concatenatedArrayString = [NSString stringWithFormat:@"%@%@%@", concatenatedArrayString,
                               cardFromArray.stringContents, @", "];
  }
  return concatenatedArrayString;
}

- (NSString *)createGameSituationLabel {
  if (!self.game.turnEnded) {
    return [self createStringFromCardsArray: self.game.currentChosenCards];
  }
  auto cardsToDisplay = @"";
  
  if ([self.game.lastMatchedCards count]) {
    cardsToDisplay = [self createStringFromCardsArray:self.game.lastMatchedCards];
    return [NSString stringWithFormat:@"%@ matched for %ld points!",
            cardsToDisplay, self.game.lastTurnScore];
  }
  cardsToDisplay = [self createStringFromCardsArray:self.game.currentChosenCards];
  return [NSString stringWithFormat:@"%@ dont match!%ld point penalty!",cardsToDisplay,
          self.game.lastTurnScore];
}

- (void)updateGameSituationLabel{
  auto gameSituationString = [self createGameSituationLabel];
  self.gameSituationLabel.text = gameSituationString;
}

- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card{
  return; //abstract
}

- (void)updateUI {
  [self updateGameSituationLabel];
  for (UIButton *cardButton in self.cardButtons) {
    auto cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
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

@end

NS_ASSUME_NONNULL_END
