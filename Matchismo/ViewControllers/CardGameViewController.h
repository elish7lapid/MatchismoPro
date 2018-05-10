// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Deck, CardMatchingGame, Card;

@interface CardGameViewController: UIViewController

@property (readonly, strong, nonatomic, nullable) CardMatchingGame *game;
@property (strong, nonatomic) NSArray *cardButtons;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController
/// the method creates and returns a new deck in the subclasses. If it is called in it's
/// abstract reference it returns \c nil.
- (nullable Deck *)createDeck;

- (UIImage *)backgroundImageForCard:(Card *)card;

- (void)startNewGame;

- (void)setCardButtonContents:(UIButton *)cardButton forCard:(Card *)card;

- (void)updateUI;


@end
NS_ASSUME_NONNULL_END
