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
  [self updateCardViewContents:cardV fromCard:card];
  return cardV;
}

- (void)updateCardViewContents:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  cardV.rank = card.rank;
  cardV.suit = card.suit;
  [self flipCardView:cardV fromCard:card];
}

- (void)flipCardView:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  if ((![self.game.lastMatchedCards count]) && self.game.turnEnded) {
    [self flipUnsucssessfullTurnEnd:cardV fromCard:card];
    return;
  }
  [self flipRegularCardView:cardV fromCard:card withDelay:0];
}

- (void)flipUnsucssessfullTurnEnd:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  if (card == self.game.lastChosenCard) {
    [self flipLastCardOfUnsucssessfullTurn:cardV fromCard:card];
    return;
  }
  [self flipRegularCardView:cardV fromCard:card withDelay:1.4];
}

- (void)flipLastCardOfUnsucssessfullTurn:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  [UIView animateWithDuration:0.8 animations:^
   { [self setAnimateCardViewFlip:cardV toFaceUp:YES];
   } completion:^(BOOL finished){
     [self flipRegularCardView:cardV fromCard:card withDelay:1];
   }];
}

- (void)flipRegularCardView:(PlayingCardView *)cardV fromCard:(PlayingCard *)card
              withDelay:(NSUInteger)delay {
  if (cardV.faceUp == card.isChosen) {
    return;
  }
  [UIView animateWithDuration:0.8 delay:delay options:UIViewAnimationOptionBeginFromCurrentState
                   animations:^{[self setAnimateCardViewFlip:cardV toFaceUp:card.isChosen];}
                   completion:nil];
}

- (void)setAnimateCardViewFlip:(PlayingCardView *)cardV toFaceUp:(BOOL)faceDirection {
  cardV.faceUp = faceDirection;
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardV cache:YES];
}

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
