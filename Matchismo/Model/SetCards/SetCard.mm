// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCard.h"

#import <UIKit/UIKit.h>

#import "SetCardContents.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card()
//The cards chosen by the user, that were found matching in the previous turn.
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;
@end

@implementation SetCard

static auto const kValidAlphas = @[[NSNumber numberWithFloat:0.3f],
                                   [NSNumber numberWithFloat:1]];
static auto const kValidColors = @[[UIColor greenColor], [UIColor purpleColor], [UIColor grayColor]];
static const NSInteger kValidMaxNumShapes = 3;
static auto const kValidShapeSymbols = @[@"▲", @"●", @"■"];


+ (NSArray<UIColor *> *)validColors {
  return kValidColors;
}

+ (NSArray<NSNumber *> *)validAlphas {
  return kValidAlphas;
}

+ (NSArray<NSString *> *)validSymbols {
  return kValidShapeSymbols;
}

+ (NSInteger)validMaximumNumShapes {
  return kValidMaxNumShapes;
}

+ (BOOL)constructorInputIsValid:(NSString *)symbol numShapes:(NSInteger)numShapes
                          color:(UIColor *)color
                       andAlpha:(NSNumber *)alpha {
  if (![kValidShapeSymbols containsObject:symbol] || numShapes > kValidMaxNumShapes ||
      numShapes < 1 || ![[SetCard validColors] containsObject:color] ||
      ![[SetCard validAlphas] containsObject:alpha]) {
    return NO;
  }
  return YES;
}

- (instancetype)initWithShapeSymbol:(NSString *)symbol numSymbols:(NSInteger)numShapes
                             color:(UIColor *)color andAlpha:(NSNumber *)alpha {
  if (self = [super init]){
    if (![SetCard constructorInputIsValid:symbol numShapes:numShapes
                                    color:color andAlpha:alpha]) {
      return nil;
    }
    _setContents = [[SetCardContents alloc] initWithShapeSymbol:symbol numSymbols:numShapes
                                                            color:color andAlpha:alpha];
  }
  return self;
}

- (NSAttributedString *)contentsAsAtributtedString {
  auto colorWithShading = [self.setContents.color
                           colorWithAlphaComponent:[self.setContents.alpha floatValue]];
  auto contentsAsString = [@"" stringByPaddingToLength:self.setContents.numSymbols*
                           [self.setContents.symbol length] withString:
                           self.setContents.symbol startingAtIndex:0];
  return [[NSAttributedString alloc] initWithString:contentsAsString
                                         attributes:@{NSForegroundColorAttributeName :
                                                        colorWithShading}];
}

- (nullable NSString *)stringContents {
  return nil;
}

- (int)match:(NSArray<SetCard *> *)otherCards {
  self.lastMatchedCards = [NSMutableArray array];
  int score = [self matchContentOfTraits:otherCards];
  if (!score) { // no match is also a match in set game.
    self.lastMatchedCards = [otherCards mutableCopy];
    return (int)[SetCardContents numberOfTraits];
  }
  if (score > 0) {
    [self.lastMatchedCards addObject:self];
  }
  return score;
}

- (int)matchContentOfTraits:(NSArray<SetCard *> *)otherCards {
  NSMutableArray<NSNumber *> *lastTraits = nil;
  for (SetCard *card in otherCards){
    if (card == self) {
      continue;
    }
    lastTraits = [self updateLastMatchCardWith:card ifTraitsAreBetterFrom:lastTraits];
  }
  return lastTraits? [(NSNumber *)[lastTraits valueForKeyPath: @"@sum.self"] intValue] : 0;
}

- (NSMutableArray<NSNumber *> *)updateLastMatchCardWith:(SetCard *)newCard
                                  ifTraitsAreBetterFrom:(NSMutableArray<NSNumber *> *)oldTraits {
  NSMutableArray<NSNumber *> *newTraits = [self gatMatchingTraitsWithOtherCard:newCard];
  if (!oldTraits) {
    [self.lastMatchedCards addObject:newCard];
    return newTraits;
  }
  auto sumNew =   [[newTraits valueForKeyPath: @"@sum.self"] integerValue];
  auto sumOld =   [[oldTraits valueForKeyPath: @"@sum.self"]  integerValue];
  if ((sumNew == sumOld) && [self isTraitsIdentical:oldTraits toTraits:newTraits]) {
    [self.lastMatchedCards addObject:newCard];
    return oldTraits;
  }
  if (sumNew > sumOld) {
    self.lastMatchedCards = [@[newCard] mutableCopy];
    return newTraits;
  }
  return oldTraits;
}

- (NSMutableArray<NSNumber *> *)gatMatchingTraitsWithOtherCard:(SetCard *)otherCard {
  auto traits = [NSMutableArray array];
  for (NSInteger i = 0; i < [SetCardContents numberOfTraits]; i++) {
    [traits addObject:@0];
  }
  if ([self.setContents isMatchingNumSymbols:otherCard.setContents]) {
    traits[0] = @1;
  }
  if ([self.setContents isMatchingSymbol:otherCard.setContents]) {
    traits[1] = @1;
  }
  if ([self.setContents isMatchingColor:otherCard.setContents]) {
    traits[2] = @1;
  }
  if ([self.setContents isMatchingAlpha:otherCard.setContents]) {
    traits[3] = @1;
  }
  return traits;
}

- (BOOL)isTraitsIdentical:(NSMutableArray<NSNumber *> *)traits1
                                  toTraits:(NSMutableArray<NSNumber *> *)traits2 {
  for (NSInteger i = 0; i < [traits1 count]; i ++) {
    if (traits1[i] != traits2[i]) {
      return NO;
    }
  }
  return YES;
}

@end

NS_ASSUME_NONNULL_END
