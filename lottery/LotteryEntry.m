#import "LotteryEntry.h"

@implementation LotteryEntry

- (void)prepareRandomNumbers {
  firstNumber = (random() % 100) + 1;
  secondNumber = (random() % 100) + 1;
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

@end