// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Card, Deck;

/// A class representing a game of matching cards.
@interface CardMatchingGame : NSObject

- (instancetype) init NS_UNAVAILABLE;

/// Initializes with the given \c count, \c deck. Where \c count is the number of cards
/// drawn randomly from \c deck.
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck NS_DESIGNATED_INITIALIZER;

/// This method represents the user choosing a card from the board. If the card is already chosen,
/// it will be un-chosen. The chosen card will be added to \c currentChosenCards.
/// If \c currentChosenCards contains cards that match to each other. they will be added to
/// \c lastMatchedCards (note that only the largest group of matching cards will be added).
/// When this method is called at the end of a turn (where in each turn the user chooses
/// \c numCardsToMatch number of cards) it will update the \c currentGameScore and the
/// \c lastTurnScore according to the number of cards matched in \c lastMatchedCards.
- (void)chooseCardAtIndex:(NSUInteger)index;

/// Returns the card at index \c index.
- (Card *)cardAtIndex:(NSUInteger)index;

/// Returns the index of \c card.
- (NSUInteger)indexOfCard:(Card *)card;

/// Adds \c numCards more cards to the game.
- (NSArray <Card *> *)dealMoreCards:(NSUInteger)numCards;

/// Removes the cards that wer'e found matching from the game.
- (void)removeMatchedCardsFromGame;

/// If \c YES, there are no more cards that can be added to the game.
- (BOOL)noMoreCardsToDeal;

/// Returns the number of cards currently in game.
- (NSUInteger)numberOfCardsInGame;

/// The current (total) game score.
@property (readonly, nonatomic) NSInteger currentGameScore;

/// The score of (only) the last turn.
@property (readonly, nonatomic) NSInteger lastTurnScore;

/// The game mode- how many cards can the user choose in a turn.
@property (nonatomic) NSInteger numCardsToMatch;

/// The list of cards that were matched successfully by the user in the last choice.
@property (readonly, nonatomic) NSMutableArray<Card *> *lastMatchedCards;

/// The last card that was chosen.
@property (readonly, nonatomic) Card *lastChosenCard;

/// If \c YES, the user just finished choosing \c numCardsToMatch from the board.
/// otherwise the user is in the middle of a turn and haven't finished choosing.
@property (nonatomic) BOOL turnEnded;

/// The card being used in the current game.
@property (readonly, nonatomic) NSMutableArray<Card *> *cards;

@end

NS_ASSUME_NONNULL_END
