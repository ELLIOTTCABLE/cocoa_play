#import "CarArrayController.h"

@implementation CarArrayController

- (id)newObject {
  id newObj = [super newObject];
  NSDate *now = [NSDate date];
  [newObj setValue:now forKey:@"datePurchased"];
  return newObj;
}

@end
