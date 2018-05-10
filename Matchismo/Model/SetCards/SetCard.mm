// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Elisheva Lapid.

#import "SetCard.h"

#import "SetCardContents.h"

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card()
/// Returns the cards chosen by the user, that were found matching
/// in the previous turn.
@property (readwrite, nonatomic) NSMutableArray<Card *> *lastMatchedCards;
@end

@implementation SetCard

static const auto kValidColors = @[[UIColor greenColor], [UIColor purpleColor], [UIColor grayColor]];
static const auto kValidAlphas = @[[NSNumber numberWithFloat:0.3f],
                                   [NSNumber numberWithFloat:1]]; //todo make 3
static const auto kValidShapeSymbols = @[@"▲", @"●", @"■"];
static const NSInteger kValidMaxNumShapes = 3; //todo make view ok for 3

+ (NSArray<UIColor *> *)validColors {
  return kValidColors;
}

+ (NSArray<NSNumber *> *)validAlphas {
  return kValidAlphas;
}

+ (NSArray<NSString *> *)validShapes {
  return kValidShapeSymbols;
}

+ (NSInteger)validMaximumNumShapes {
  return kValidMaxNumShapes;
}

+ (BOOL)constructorInputIsValid:(NSString *)symbol numShapes:(NSInteger)numShapes
                          color:(UIColor *)color
                       andAlpha:(NSNumber *)alpha {
  if (![kValidShapeSymbols containsObject:symbol] || numShapes > kValidMaxNumShapes ||
      numShapes < 1 || ![[SetCard validColors] containsObject:color] || ![[SetCard validAlphas] containsObject:alpha]) {
    return NO;
  }
  return YES;
}

-(instancetype)initWithShapeSymbol:(NSString *)symbol numShapes:(NSInteger)numShapes
                             color:(UIColor *)color andAlpha:(NSNumber *)alpha {
  if (self = [super init]){
    if (![SetCard constructorInputIsValid:symbol numShapes:numShapes
                                    color:color andAlpha:alpha]) {
      return nil;
    }
    _shapeContents = [[SetCardContents alloc] initWithShapeSymbol:symbol numShapes:numShapes
                                                            color:color andAlpha:alpha];
  }
  return self;
}

- (NSAttributedString *)contentsAsAtributtedString {
  auto colorWithShading = [self.shapeContents.color
                           colorWithAlphaComponent:[self.shapeContents.alpha floatValue]];
  auto contentsAsString = [@"" stringByPaddingToLength:self.shapeContents.numShapes*[self.shapeContents.shapeSymbol length] withString: self.shapeContents.shapeSymbol startingAtIndex:0];
  return [[NSAttributedString alloc] initWithString:contentsAsString attributes:@{NSForegroundColorAttributeName : colorWithShading}];
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
  NSInteger sumNew =   [[newTraits valueForKeyPath: @"@sum.self"] integerValue];
  NSInteger sumOld =   [[oldTraits valueForKeyPath: @"@sum.self"]  integerValue];
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

- (NSMutableArray<NSNumber *> *)gatMatchingTraitsWithOtherCard:(SetCard *)otherCard{
  auto traits = [NSMutableArray array];
  for (NSInteger i = 0; i < [SetCardContents numberOfTraits]; i++) {
    [traits addObject:@0];
  }
  if ([self.shapeContents isMatchingNumShapes:otherCard.shapeContents]) {
    traits[0] = @1;
  }
  if ([self.shapeContents isMatchingShapeSymbol:otherCard.shapeContents]) {
    traits[1] = @1;
  }
  if ([self.shapeContents isMatchingColor:otherCard.shapeContents]) {
    traits[2] = @1;
  }
  if ([self.shapeContents isMatchingAlpha:otherCard.shapeContents]) {
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
