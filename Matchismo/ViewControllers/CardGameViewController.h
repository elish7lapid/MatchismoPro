// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Card, CardMatchingGame, CardView, Deck, Grid;

/// View controller for a generall card game. Note that some of the methods are abstract.
@interface CardGameViewController: UIViewController

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Re-sets the view and the \c game property for a new game. The method is called each time a
/// new game starts.
- (void)startNewGame;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Sets the contents displayed on \c cardV to match the contents of \c card.
/// And animates transitions.
- (void)updateCardViewContents:(CardView *)cardV fromCard:(Card *)card;

/// Updates the display on the screen to match the current game state.
- (void)updateUI;

/// Creates the display of card views on a grid on the \c cardsSpace view.
- (void)createCardsOnGrid;

- (void)initializeCardsArray;

- (void)initializeGame;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Creates a new card view matching \c card. The view will be created in the given \c rect.
- (nullable CardView *)initializeBasicCardViewFromCard:(Card *)card inRect:(CGRect)rect;

/// Object handling the logic of the game that is currently played in the \c CardGameViewController.
@property (strong, readonly, nonatomic, nullable) CardMatchingGame *game;

@property (nonatomic) NSUInteger numCardsToMatch;

@property (nonatomic) NSUInteger scaleMinimumNumCards;

/// A view that holds the cards.
@property (weak, readonly, nonatomic) UIView *cardsSpace;

/// Card views currently displayed on screen.
@property (strong, nonatomic) NSMutableArray<CardView *> *cards;

/// A grid that orders the \c cards on the \c cardsSpace.
@property (nonatomic) Grid *grid;

- (nullable Deck *)createDeck;

@end
NS_ASSUME_NONNULL_END
