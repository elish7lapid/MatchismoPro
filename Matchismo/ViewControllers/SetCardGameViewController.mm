// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCardGameViewController.h"

#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetCardGameViewController

@dynamic cardButtons;

@synthesize game = _game;

static const NSUInteger kNumCardsToMatch = 3;

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
  return [[SetCardDeck alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.game.numCardsToMatch = kNumCardsToMatch;
  [super updateUI];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfrontChosen" : @"cardfront"];
}

- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card {
  [cardButton setAttributedTitle:[(SetCard *)card contentsAsAtributtedString] forState:UIControlStateNormal];
}

@end

NS_ASSUME_NONNULL_END
