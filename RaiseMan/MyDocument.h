#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument {
  NSMutableArray *employees;
}
- (void)setEmployees:(NSMutableArray *)a;
@end
