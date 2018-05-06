// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Deck;

@interface CardGameViewController : UIViewController

/// An abstrct method which is only implemented by subclasses of \c CardGameViewController
/// the method creates and returns a new deck in the subclasses. If it is called in it's
/// abstract reference it returns \c nil.
- (nullable Deck *)createDeck;

@end
NS_ASSUME_NONNULL_END
