#import <Foundation/Foundation.h>

@interface LotteryEntry : NSObject {
  NSCalendarDate *entryDate;
  int firstNumber;
  int secondNumber;
}
- (void)prepareRandomNumbers;
- (void)setEntryDate:(NSCalendarDate *)date;
- (NSCalendarDate *)entryDate;
- (int)firstNumber;
- (int)secondNumber;
@end