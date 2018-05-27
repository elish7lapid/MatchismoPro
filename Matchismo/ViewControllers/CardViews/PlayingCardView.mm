// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

static const auto kDefaultFaceCardScaleFactor = 0.10;
static NSArray * const kValidRanks = @[@"?",@"A",@"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9",
                                       @"10", @"J", @"Q", @"K"];

- (void)drawContents {
  if (!self.faceUp) {
    [self drawFaceDown];
    return;
  }
  [self drawMiddleShape];
  [self drawCornerShapes];
}

- (void)drawFaceDown {
  [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
}

- (void)drawMiddleShape {
  UIImage *faceIm = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString],
                                            self.suit]];
  if (!faceIm) {
    [self drawCenterNumber];
    return;
  }
  [self drawFaceWithImage:faceIm];
}

- (void)drawCenterNumber {
  auto numText = [@"" stringByPaddingToLength:[self.suit length] * self.rank
                                   withString: self.suit startingAtIndex:0];
  auto centerText = [self createCenteredTextFromString:numText];
  CGRect centeRect = CGRectInset(self.bounds, (self.bounds.size.width/2)  -
                                 ([centerText size].width/self.rank), (self.bounds.size.height/2)  -
                                 ([centerText size].height * ceil(self.rank / 4.0)));
  [centerText drawInRect:centeRect];
}

- (void)drawFaceWithImage:(UIImage *)faceIm {
  CGRect centeRect = CGRectInset(self.bounds, self.bounds.size.width * self.faceCardScaleFactor,
                                 self.bounds.size.height * self.faceCardScaleFactor);
  [faceIm drawInRect:centeRect];
}

- (void)drawCornerShapes {
  auto rankSuit = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit];
  auto cornerText = [self createCenteredTextFromString:rankSuit];
  CGRect textBounds;
  textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
  textBounds.size = [cornerText size];
  [cornerText drawInRect:textBounds];
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
  CGContextRotateCTM(context, M_PI);
  [cornerText drawInRect:textBounds];
}

- (NSAttributedString *)createCenteredTextFromString:(NSString *)centeredStr {
  auto parStyle = [[NSMutableParagraphStyle alloc] init];
  parStyle.alignment = NSTextAlignmentCenter;
  UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
  auto attribs = @{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : parStyle};
  NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:centeredStr
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

- (CGFloat)faceCardScaleFactor {
  if (_faceCardScaleFactor == 0) {
    _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
  }
  return _faceCardScaleFactor;
}

@end

NS_ASSUME_NONNULL_END
