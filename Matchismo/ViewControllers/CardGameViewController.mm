// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "Grid.h"

#import "CardGameViewController.h"

#import "Card.h"
#import "CardMatchingGame.h"
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardGameViewController()

/// Label representing the current score in the game.
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

/// A UIView holding the \c CardViews.
@property (readwrite, nonatomic) IBOutlet UIView *cardsSpace;

/// A label that is presented when there are no more cards to deal.
@property (weak, nonatomic) IBOutlet UILabel *outOfCardsLabel;

/// If \c YES, the cards are piled and can be moved by the user. Else the regular game view is on.
@property (nonatomic) BOOL pileModeOn;

/// Array holding attachment behaviour for each card that causes the cards to move when they are in
/// \c pileModeOn.
@property (nonatomic, nullable) NSMutableArray <UIAttachmentBehavior *> *movePile;

/// An animator allowing adding animated behaviours to the view.
@property (nonatomic) UIDynamicAnimator *animator;

/// A grid that orders the \c cards on the \c cardsSpace.
@property (nonatomic) Grid *grid;

@end

@implementation CardGameViewController

static const auto kCardsSizeRatio = 0.6;
static const auto kCardsScaleFactor = 0.9;

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initGrid];
  _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.cardsSpace];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self relocateCardsOnGrid];
}

#pragma mark -

- (void)initGrid {
  _grid = [[Grid alloc] init];
  self.grid.cellAspectRatio = kCardsSizeRatio;
  self.grid.size = _cardsSpace.bounds.size;
  self.grid.minimumNumberOfCells = self.numCardsToMatch*self.scaleMinimumNumCards;
}

- (IBAction)touchRestartButton:(UIButton *)sender {
  [self startNewGame];
  [self updateUI];
}

- (void)updateUI {
  for (CardView *cardView in self.cardViews) {
    [self updateUIForCardView:cardView];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.currentGameScore];
}

- (void)updateUIForCardView:(CardView *)cardV {
  auto cardViewIndex = [self.cardViews indexOfObject:cardV];
  auto card = [self.game cardAtIndex:cardViewIndex];
  [self updateCardViewContents:cardV fromCard:card];
}

// An abstract method.
- (void)updateCardViewContents:(CardView *)cardV fromCard:(Card *)card {
  return;
}

- (void)startNewGame {
  self.outOfCardsLabel.text = @"";
  self.grid.minimumNumberOfCells = self.numCardsToMatch * self.scaleMinimumNumCards;
  [self initializeCardsArray];
  [self initializeGame];
  [self animateCreateCardViewsFromCards:self.game.cards];
}

- (void)initializeCardsArray {
  if (!_cardViews) {
    _cardViews = [NSMutableArray array];
  }
  else {
    [self.cardViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _cardViews = [NSMutableArray array];
  }
}

// Abstract method.
- (void)initializeGame {
  return;
}

- (IBAction)tapDealButton:(id)sender {
  if ([self.game noMoreCardsToDeal]) {
    self.outOfCardsLabel.text = @"Out of cards!";
    return;
  }
  auto newCards = [self.game dealMoreCards:self.numCardsToMatch];
  [self animateCreateCardViewsFromCards:newCards];
}

- (void)animateCreateCardViewsFromCards:(NSArray<Card *> *)cards {
  for (Card* card in cards) {
    auto cardV = [self createCardViewInRect:CGRectMake(0, 0, 10, 20) forCard:card];
    [self addCardViewToGame:cardV];
  }
  [self relocateCardsOnGrid];
}

- (CardView *)createCardViewInRect:(CGRect)rect forCard:(Card *)card {
  return [self initializeBasicCardViewFromCard:card inRect:[self createScaledRectInFrame:rect]];
}

// Abstract method.
- (nullable CardView *)initializeBasicCardViewFromCard:(Card *)card inRect:(CGRect)rect {
  return nil;
}

- (void)addCardViewToGame:(CardView *)cardV {
  [self setTappingForCardView:cardV];
  [self.cardViews addObject:cardV];
  [self.cardsSpace addSubview:cardV];
}

- (void)setTappingForCardView:(CardView *)cardV {
  auto tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCard:)];
  [cardV addGestureRecognizer:tapgr];
}

- (void)tapCard:(UITapGestureRecognizer *)recognizer {
  if (self.pileModeOn) {
    [self pileModeTapping];
    return;
  }
  auto pressed = (CardView *)recognizer.view;
  auto chosenButtonIndex = [self.cardViews indexOfObject:pressed];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];
}

- (void)relocateCardsOnGrid {
  [self readjustGrid];
  [self animateRelocateCardsOnGrid];
}

- (void)readjustGrid {
  self.grid.minimumNumberOfCells = [self.cardViews count];
  self.grid.size = _cardsSpace.bounds.size;
}

- (void)animateRelocateCardsOnGrid {
  for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
    for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
      [self relocateCardViewOnRow:i col:j];
    }
  }
}

- (void)relocateCardViewOnRow:(NSUInteger)row col:(NSUInteger)col {
  auto flatIdx = (self.grid.columnCount * row) + col;
  if (flatIdx >= [self.cardViews count]) {
    return;
  }
  auto cardV = [self.cardViews objectAtIndex:flatIdx];
  auto frame = [self.grid frameOfCellAtRow:row inColumn:col];
  if (CGPointEqualToPoint(cardV.center, [self.grid centerOfCellAtRow:row inColumn:col])) {
    return;
  }
  [self animateReadjustFrame:frame forCardView:cardV];
}

- (void)animateReadjustFrame:(CGRect)frame forCardView:(CardView *)cardV {
  [UIView animateWithDuration:0.8 animations:^{
    [cardV setFrame:[self createScaledRectInFrame:frame]];
  }];
}

- (CGRect)createScaledRectInFrame:(CGRect)frame {
  auto x = frame.origin.x + (frame.size.width*(1 - kCardsScaleFactor)/2);
  auto y = frame.origin.y + (frame.size.height*(1 - kCardsScaleFactor)/2);
  return CGRectMake(x, y, frame.size.width*kCardsScaleFactor, frame.size.height*kCardsScaleFactor);
}

- (void)removeCardsFromViewWithFadeOut:(NSArray<CardView *> *)cardsToRemove {
  [UIView animateWithDuration:0.8 animations:^{[self fadeOutCardViews:cardsToRemove];}
                   completion:^(BOOL finished){
                     [self removeCardsFromView:cardsToRemove];
                     [self relocateCardsOnGrid];
                   }];
}

- (void)fadeOutCardViews:(NSArray<CardView *> *)cardViews {
  for (CardView *cardV in cardViews) {
    cardV.alpha = 0.0;
  }
}

- (void)removeCardsFromView:(NSArray<CardView *> *)cardsToRemove {
  [self.cardViews removeObjectsInArray:cardsToRemove];
  [cardsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (IBAction)pinchToPileCards:(UIPinchGestureRecognizer *)sender {
 if (sender.state == UIGestureRecognizerStateEnded) {
   self.pileModeOn = YES;
   auto gridRec = [self.grid frameOfCellAtRow:0 inColumn:0];
   auto rect = CGRectMake(self.cardsSpace.center.x - gridRec.size.width/2,
                          self.cardsSpace.center.y - gridRec.size.height/2, gridRec.size.width,
                          gridRec.size.height);
   rect = [self createScaledRectInFrame:rect];
   for (CardView *cardV in self.cardViews) {
     [self animateReadjustFrame:rect forCardView:cardV];
   }
  }
}

- (IBAction)panMovePiledCards:(UIPanGestureRecognizer *)sender {
  auto loc = [sender locationInView:self.cardsSpace];
  if (sender.state == UIGestureRecognizerStateBegan) {
    [self attachCardViewsPileToPoint:loc];
  } else if (sender.state == UIGestureRecognizerStateChanged) {
    for (UIAttachmentBehavior *behave in self.movePile) {
      behave.anchorPoint = loc;
    }
  } else if (sender.state == UIGestureRecognizerStateEnded) {
    for (UIAttachmentBehavior *behave in self.movePile) {
      [self.animator removeBehavior:behave];
    }
  }
}

- (void)attachCardViewsPileToPoint:(CGPoint)point {
  if (self.pileModeOn) {
    self.movePile = [NSMutableArray array];
    for (CardView *cardV in self.cardViews) {
      [self attachCardView:cardV toAnchorPoint:point];
    }
  }
}

- (void)attachCardView:(CardView *)cardV toAnchorPoint:(CGPoint)point {
  auto behave = [[UIAttachmentBehavior alloc] initWithItem:cardV attachedToAnchor:point];
  [self.movePile addObject:behave];
  [self.animator addBehavior:behave];
}

- (void)pileModeTapping {
  self.pileModeOn = NO;
  self.movePile = nil;
  [self relocateCardsOnGrid];
}


@end

NS_ASSUME_NONNULL_END
