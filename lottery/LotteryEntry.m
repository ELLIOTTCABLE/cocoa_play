#import "LotteryEntry.h"

@implementation LotteryEntry

- (id)init {
  return [self initWithEntryDate:[NSCalendarDate calendarDate]];
}

- (id)initWithEntryDate:(NSCalendarDate *)theDate {
  if (![super init])
    return nil;
  
  [theDate setCalendarFormat:@"%Y-%m-%d@%H:%M:%S"];
  entryDate = [theDate retain];
  firstNumber = random() % 100 + 1;
  secondNumber = random() % 100 + 1;
  
  return self;
}

- (void)dealloc {
  NSLog(@"De-allocating %@", self);
  [entryDate release];
  [super dealloc];
}

- (void)setEntryDate:(NSCalendarDate *)date {
  [date retain];
  [entryDate release];
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
  return [NSString stringWithFormat:@"%@ = %d and %d",
          [entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
          firstNumber, secondNumber];
}

@end