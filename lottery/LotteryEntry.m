#import "LotteryEntry.h"

@implementation LotteryEntry

- (id)init {
  if (![super init])
    return nil;
  
  firstNumber = (random() % 100) + 1;
  secondNumber = (random() % 100) + 1;
  
  return self;
}

- (void)setEntryDate:(NSCalendarDate *)date {
  entryDate = date;
}

- (NSCalendarDate *)entryDate {
  return entryDate;
}

- (int)firstNumber {
  return firstNumber;
}

- (int)secondNumber {
  return secondNumber;
}

- (NSString *)description {
  return [[NSString alloc] initWithFormat:@"%@ = %d and %d",
          [entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
          firstNumber, secondNumber];
}

@end