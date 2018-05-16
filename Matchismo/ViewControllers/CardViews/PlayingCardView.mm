// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

static const auto kDefaultFaceCardScaleFactor = 0.10;
static NSArray * const kValidRanks = @[@"?",@"A",@"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
                                  @"J", @"Q", @"K"];

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
  }
  return self;
}

- (void)drawContents {
  if (!self.faceUp) {
    [self drawFaceDown];
    return;
  }
  [self drawFace];
  [self drawCornerShapes];
}

- (void)drawFaceDown {
  [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
}

- (void)drawFace {
  UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString],
                                            self.suit]];
  if (!faceImage) {
    return;
  }
  CGRect imRect = CGRectInset(self.bounds, self.bounds.size.width * self.faceCardScaleFactor,
                              self.bounds.size.height * self.faceCardScaleFactor);
  [faceImage drawInRect:imRect];
}

- (void)drawCornerShapes {
  auto cornerText = [self createCornerText];
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect:textBounds];
}

- (NSAttributedString *)createCornerText {
  auto parStyle = [[NSMutableParagraphStyle alloc] init];
  parStyle.alignment = NSTextAlignmentCenter;
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  auto rankSuit = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit];
  auto attribs = @{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : parStyle};
  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:rankSuit
                                                                   attributes:attribs];
  return cornerText;
}

- (NSString *)rankAsString {
  return kValidRanks[self.rank];
}


- (void)setRank:(NSUInteger)rank {
  if (_rank == rank) {
    return;
  }
  _rank = rank;
  [self setNeedsDisplay]; //TODO:(Elisheva) doesn't happen automatically?
}

- (void)setSuit:(NSString *)suit {
  if (_suit == suit) {
    return;
  }
  _suit = suit;
  [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
  if (_faceUp == faceUp) {
    return;
  }
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
  if (_faceCardScaleFactor == faceCardScaleFactor) {
    return;
  }
  _faceCardScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
