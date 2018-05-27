// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Card, CardMatchingGame, CardView, Deck, Grid;

/// View controller for a generall card game. Note that some of the methods are abstract.
@interface CardGameViewController: UIViewController

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController
/// the method creates and returns a new deck of cards that will be past to the \c game property.
/// If it is called in it's abstract reference it returns \c nil.
- (nullable Deck *)createDeck;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Returns the background image to be displayed on a card. This method is called every time
/// the view updates. If it is called in it's abstract reference it returns \c nil.
- (nullable UIImage *)backgroundImageForCard:(Card *)card;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Returns a string representing the contents of the cards in \c cardsArray. If it is called in
/// it's abstract reference it returns \c nil.
- (nullable NSMutableAttributedString *)createStringFromCardsArray:
  (NSMutableArray<Card *> *) cardsArray;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Re-sets the view and the \c game property for a new game. The method is called each time a
/// new game starts.
- (void)startNewGame;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Sets the contents displayed on \c cardButton to match the contents of \c card.
- (void)setCardViewContents:(CardView *)cardView forCard:(Card *)card;

/// Updates the display on the screen to match the current game state.
- (void)updateUI;

- (nullable CardView *)createCardViewFromCard:(Card *)card inRect:(CGRect)rect;

- (void)createCardsOnGrid;

/// Object handling the logic of the game that is currently played in the \c CardGameViewController.
@property (strong, readonly, nonatomic, nullable) CardMatchingGame *game;

/// The view that holds the cards.
@property (weak, readonly, nonatomic) UIView *cardsSpace;

@property (strong, readonly, nonatomic) NSMutableArray<CardView *> *cards;

/// The grid of cards on the board.
@property (nonatomic) Grid *grid;

@end
NS_ASSUME_NONNULL_END
