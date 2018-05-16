// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController()
// The card buttons displayed in the view.
@property (weak, nonatomic) IBOutlet PlayingCardView *blob;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation PlayingCardGameViewController

@dynamic cardButtons;

@synthesize game = _game;

// Number of cards that are matched in one turn of the matching game.
static const NSUInteger kNumCardsToMatch = 2;

- (void)viewDidLoad {
  [super viewDidLoad];
  _blob.rank = 13;
  _blob.suit = @"♥︎";
  _blob.faceUp= YES;
  [self startNewGame];
}

- (void)startNewGame {
  _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                            usingDeck:[self createDeck]];
  self.game.numCardsToMatch = kNumCardsToMatch;
}

- (nullable Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (nullable UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card {
  [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.stringContents : @"";
}

- (nullable NSMutableAttributedString *)createStringFromCardsArray:
           (NSMutableArray<Card *> *)cardsArray {
  auto concatenatedArrayString = @"";
  for (Card *cardFromArray in cardsArray) {
    concatenatedArrayString = [NSString stringWithFormat:@"%@%@%@", concatenatedArrayString,
                               cardFromArray.stringContents, @", "];
  }
  return [[NSMutableAttributedString alloc] initWithString:concatenatedArrayString];
}

@end

NS_ASSUME_NONNULL_END
