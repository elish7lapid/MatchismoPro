// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardGameViewController.h"

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

@synthesize game = _game;
@synthesize scaleMinimumNumCards = _scaleMinimumNumCards;
@synthesize numCardsToMatch = _numCardsToMatch;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
  _numCardsToMatch = 2;
  _scaleMinimumNumCards = 6;
  [super viewDidLoad];
  [self startNewGame];
}

#pragma mark -
#pragma mark CardGameViewController

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (void)initializeGame {
  _game = [[CardMatchingGame alloc] initWithCardCount:self.numCardsToMatch*self.scaleMinimumNumCards
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = self.numCardsToMatch;
}

- (nullable CardView *)initializeBasicCardViewFromCard:(PlayingCard *)card inRect:(CGRect)rect {
  auto cardV = [[PlayingCardView alloc] initWithFrame:rect];
  [self updateCardViewContents:cardV fromCard:card];
  return cardV;
}

- (void)updateUI {
  if ((![self.game.lastMatchedCards count]) && self.game.turnEnded) {
    auto cardV = (PlayingCardView *)[self.cardViews objectAtIndex:
                                     [self.game indexOfCard:self.game.lastChosenCard]];
    if (!cardV.faceUp) {
      [self handleUnsuccessfullTurnFlipofCardView:cardV];
      return;
    }
  }
  [super updateUI];
}

- (void)updateCardViewContents:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  cardV.rank = card.rank;
  cardV.suit = card.suit;
  if (cardV.faceUp == card.isChosen) {
    return;
  }
  [self flipCardView:cardV ToFaceUp:card.isChosen];
}

#pragma mark -

- (void)handleUnsuccessfullTurnFlipofCardView:(PlayingCardView *)cardV {
  [UIView animateWithDuration:0.8 animations:^{[self setAnimateCardViewFlip:cardV toFaceUp:YES];}
                   completion:^(BOOL finished){[self performSelector:@selector(updateUI)
                                                          withObject:nil afterDelay:0.5];}];
}

- (void)flipCardView:(PlayingCardView *)cardV ToFaceUp:(BOOL)up {
  [UIView animateWithDuration:0.8 animations:^{[self setAnimateCardViewFlip:cardV toFaceUp:up];}];
}

- (void)setAnimateCardViewFlip:(PlayingCardView *)cardV toFaceUp:(BOOL)faceDirection {
  cardV.faceUp = faceDirection;
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardV cache:YES];
}

@end

NS_ASSUME_NONNULL_END
