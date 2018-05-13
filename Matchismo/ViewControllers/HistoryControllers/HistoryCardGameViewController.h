// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// View controller object for the history view that shows the history of a card game.
@interface HistoryCardGameViewController : UIViewController

/// Adds \c event to be displayed as part of the game's history.
- (void)addHistory:(NSAttributedString *)event;

@end

NS_ASSUME_NONNULL_END
