// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardView()
/// A scale factor for the face drawn in the middle of a playing card.
@property (nonatomic) CGFloat faceScaleFactor;
@end

@implementation PlayingCardView

@synthesize faceScaleFactor = _faceScaleFactor;

/// Valid ranks for a playing card.
static NSArray * const kValidRanks = @[@"?",@"A",@"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9",
                                       @"10", @"J", @"Q", @"K"];

#pragma mark -
#pragma mark CardView

- (void)drawContents {
  if (!self.faceUp) {
    [self drawFaceDown];
    return;
  }
  [self drawMiddleShape];
  [self drawCornerShapes];
}

#pragma mark -

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
  auto centerWidth = ([centerText size].width/self.rank)*2;
  auto centerHeight = [centerText size].height * ceil(self.rank / 2.0);
  CGRect centeRect = CGRectMake((self.bounds.size.width/2)  - centerWidth/2,
                                (self.bounds.size.height/2) - centerHeight/2, centerWidth,
                                centerHeight);
  [centerText drawInRect:centeRect];
}

- (void)drawFaceWithImage:(UIImage *)faceIm {
  CGRect centeRect = CGRectInset(self.bounds, self.bounds.size.width * self.faceScaleFactor,
                                 self.bounds.size.height * self.faceScaleFactor);
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
  [self setNeedsDisplay]; 
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

- (void)setFaceScaleFactor:(CGFloat)faceCardScaleFactor {
  if (_faceScaleFactor == faceCardScaleFactor) {
    return;
  }
  _faceScaleFactor = faceCardScaleFactor;
  [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
