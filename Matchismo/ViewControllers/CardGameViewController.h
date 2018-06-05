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

/// Removing \c cardsToRemove from game with a fade out animation.
- (void)removeCardsFromViewWithFadeOut:(NSArray<CardView *> *)cardsToRemove;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Initializes the game.
- (void)initializeGame;

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController.
/// Creates a new card view matching \c card. The view will be created in the given \c rect.
- (nullable CardView *)initializeBasicCardViewFromCard:(Card *)card inRect:(CGRect)rect;

/// Object handling the logic of the game that is currently played in the \c CardGameViewController.
@property (strong, readonly, nonatomic, nullable) CardMatchingGame *game;

/// The number of cards that the user can try matching in each turn.
@property (nonatomic) NSUInteger numCardsToMatch;

/// The minimal number of cards that will be displayed in the beggining of the game is
/// \c scaleMinimumNumCards * numCardsToMatch.
@property (nonatomic) NSUInteger scaleMinimumNumCards;

/// Card views currently displayed on screen.
@property (strong, nonatomic) NSMutableArray<CardView *> *cardViews;

@end

NS_ASSUME_NONNULL_END
