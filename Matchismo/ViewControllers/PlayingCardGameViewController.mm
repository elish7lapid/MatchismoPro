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

- (void)updateCardViews {
  if ((![self.game.lastMatchedCards count]) && self.game.turnEnded) {
    [self unsuccessfullTurnEndUpdateCardViews];
    return;
  }
  [self regularUpdateCardViews];
}

- (void)unsuccessfullTurnEndUpdateCardViews {
  auto cardsChanged = [self getFaceUpAndLastChosenCardViews];
  [UIView animateWithDuration:0.8 animations:^
   { cardsChanged[1].faceUp = YES;
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardsChanged[1] cache:YES];
   } completion:^(BOOL finished){[UIView animateWithDuration:0.8 animations:^{
     cardsChanged[1].faceUp = NO;
     cardsChanged[0].faceUp = NO;
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardsChanged[1] cache:YES];
     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardsChanged[0] cache:YES];
   }];}];
  
}

- (NSArray<PlayingCardView *> *)getFaceUpAndLastChosenCardViews {
  PlayingCardView *faceUpCard = nil;
  PlayingCardView *lastChosen = nil;
  for (PlayingCardView *cardV in self.cards) {
    auto cardViewIndex = [self.cards indexOfObject:cardV];
    auto card = [self.game cardAtIndex:cardViewIndex];
    if (card == self.game.lastChosenCard) {
      lastChosen = cardV;
    }
    else if ((cardV.faceUp && !card.isMatched)) {
      faceUpCard = cardV;
    }
  }
  return @[faceUpCard, lastChosen];
}

- (void)regularUpdateCardViews {
  for (PlayingCardView *cardView in self.cards) {
    [self updateUIForCardView:cardView];
  }
}

- (void)updateUIForCardView:(PlayingCardView *)cardV {
  auto cardViewIndex = [self.cards indexOfObject:cardV];
  auto card = [self.game cardAtIndex:cardViewIndex];
  [self updateCardViewContents:cardV fromCard:card];
}

- (void)updateCardViewContents:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  cardV.rank = card.rank;
  cardV.suit = card.suit;
  [self flipCardView:cardV fromCard:card];
}

- (void)flipCardView:(PlayingCardView *)cardV fromCard:(PlayingCard *)card {
  if (cardV.faceUp == card.isChosen) {
    return;
  }
  cardV.faceUp = card.isChosen;
  [self flipToCardView:cardV];
}

- (void)flipToCardView:(PlayingCardView *)otherV {
  [UIView animateWithDuration:0.8 animations:^
   {[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:otherV cache:YES];
   }];
}

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

@end

NS_ASSUME_NONNULL_END
