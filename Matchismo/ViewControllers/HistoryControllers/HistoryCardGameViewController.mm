// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "HistoryCardGameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCardGameViewController()

// Text view object displaying the history of the game.
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

// String describing the history.
@property (nonatomic) NSMutableAttributedString *history;

@end

@implementation HistoryCardGameViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  if (!self.history) {
    [self.historyTextView setAttributedText:[[NSAttributedString alloc]
                                             initWithString:@"No history to show.."]];
    return;
  }
  [self.historyTextView setAttributedText:self.history];
}

- (void)addHistory:(NSAttributedString *)event {
  if (!self.history) { //TODO:(Elisheva) ask.
    _history = [[NSMutableAttributedString alloc] initWithString:@""];
  }
  [self.history appendAttributedString:event];
  [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}
@end

NS_ASSUME_NONNULL_END
