// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardGameViewController.h"

#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardGameViewController()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation PlayingCardGameViewController

@dynamic cardButtons;

@synthesize game = _game;

static const NSUInteger kNumCardsToMatch = 2;

- (void)viewDidLoad {
  [super viewDidLoad];
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

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card {
  [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
}

- (NSString *)titleForCard:(Card *)card {
  return card.isChosen ? card.stringContents : @"";
}

@end

NS_ASSUME_NONNULL_END
