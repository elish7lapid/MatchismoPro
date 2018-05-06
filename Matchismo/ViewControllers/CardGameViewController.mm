// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController ()

@property (strong, nonatomic, nullable) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameSituationLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegment;
@property (nonatomic) BOOL gameStarted;

@end

@implementation CardGameViewController

+ (NSArray *)getGameModesMappedToSegments {
  return @[@2, @3];
}

- (nullable Deck *)createDeck {
  return nil;
}

- (nullable CardMatchingGame *)game {
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    [self initGameMode];
  }
  return _game;
}

- (void)initGameMode {
  if (self.gameModeSegment.selectedSegmentIndex == UISegmentedControlNoSegment) {
    _game.numCardsToMatch = 2;
    return;
  }
  _game.numCardsToMatch = [[CardGameViewController getGameModesMappedToSegments]
                           [self.gameModeSegment.selectedSegmentIndex] integerValue];
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSString *)createStringFromCardsArray:(NSMutableArray<Card *> *) cardsArray{
  auto concatenatedArrayString = @"";
  for (Card *cardFromArray in cardsArray) {
    concatenatedArrayString = [NSString stringWithFormat:@"%@%@%@", concatenatedArrayString,
                               cardFromArray.contents, @", "];
  }
  return concatenatedArrayString;
}

- (NSString *)createGameSituationLabel{
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

- (void)updateUI {
  [self updateGameSituationLabel];
  for (UIButton *cardButton in self.cardButtons) {
    auto cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.currentGameScore];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  if (!self.gameStarted) {
    self.gameStarted = TRUE;
    self.gameModeSegment.enabled = FALSE;
  }
  auto chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (IBAction)touchRestartButton:(UIButton *)sender {
  self.game = nil;
  self.gameStarted = FALSE;
  self.gameModeSegment.enabled = TRUE;
  [self updateUI];
}

- (IBAction)touchGameModeSegment:(UISegmentedControl *)sender {
  auto numCardsToMatch = [[CardGameViewController getGameModesMappedToSegments]
                          [sender.selectedSegmentIndex] integerValue];
  self.game.numCardsToMatch = numCardsToMatch;
}

@end

NS_ASSUME_NONNULL_END
